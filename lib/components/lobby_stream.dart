import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dicery/components/buttons/everyoneisin_button.dart';
import 'package:dicery/components/player_card.dart';
import 'package:dicery/utilities/api.dart';
import 'package:dicery/utilities/lobby.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LobbyStream extends StatefulWidget {
  const LobbyStream({
    Key key,
    @required this.roomCode,
    @required this.isOwnedByUser,
    @required this.roomOwner,
  }) : super(key: key);

  final String roomCode;
  final bool isOwnedByUser;
  final String roomOwner;

  @override
  _LobbyStreamState createState() => _LobbyStreamState();
}

class _LobbyStreamState extends State<LobbyStream> with WidgetsBindingObserver {
  List<String> players = <String>[];
  bool _streamHasError = false;
  StreamSubscription _streamSubscription;
  DiceryApi api = DiceryApi();
  var channel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    streamPlayersJoining();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _streamSubscription.pause();
    } else if (state == AppLifecycleState.resumed) {
      _streamSubscription.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_streamHasError) {
      return Expanded(child: Text('Error!'));
    }

    return Expanded(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) =>
                  PlayerCard(emoji: '✨', name: players[index]),
            ),
          ),
          if (widget.isOwnedByUser)
            EveryonesInButton(
                playerCount: players.length,
                roomOwner: widget.roomOwner,
                roomCode: widget.roomCode),
        ],
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void streamPlayersJoining() async {
    channel = await Lobby.Subscribe(api, widget.roomCode);
    var stream = (kIsWeb) ? channel.stream : channel.stream.toStringStream();
    _streamSubscription = stream.listen(
      (data) {
        if (data == Lobby.CLOSE_ROOM_COMMAND) {
          channel.close();
          return;
        }
        final newPlayers = Lobby.InterpretData(data);
        if (!(const IterableEquality().equals(newPlayers, players))) {
          players.addAll(newPlayers);
          setState(() {
            players = players.toSet().toList();
          });
        }
      },
      onDone: exitLobby,
      onError: (err) => setState(() => _streamHasError = true),
    );
  }

  void exitLobby() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/room',
      // Remove all screens below.
      (route) => false,
      arguments: {
        'roomOwner': widget.roomOwner,
        'roomCode': widget.roomCode,
      },
    );
  }
}
