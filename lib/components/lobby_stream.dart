import 'dart:async';

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
  final players = <String>[];
  bool _streamHasError = false;
  StreamSubscription _streamSubscription;

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
    var api = DiceryApi();
    var channel = await Lobby.Subscribe(api, widget.roomCode);
    var stream = (kIsWeb) ? channel.stream : channel.stream.toStringStream();
    _streamSubscription = stream.listen(
      (data) {
        final newPlayers = Lobby.InterpretData(data);
        if (newPlayers.isNotEmpty) {
          setState(() => players.insertAll(0, newPlayers));
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
