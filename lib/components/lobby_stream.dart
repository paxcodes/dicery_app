import 'dart:async';
import 'package:dicery/utilities/lobby.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:dicery/components/buttons/everyoneisin_button.dart';
import 'package:dicery/components/player_card.dart';
import 'package:dicery/components/stream_listenable_builder.dart';

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

class _LobbyStreamState extends State<LobbyStream> {
  final _client = http.Client();
  Future<http.StreamedResponse> streamedResponseFuture;
  final players = <String>[];

  @override
  void initState() {
    streamedResponseFuture = Lobby.Subscribe(_client, widget.roomCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.StreamedResponse>(
      future: streamedResponseFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final streamedResponse = snapshot.data;
          return StreamListenableBuilder<String>(
            stream: streamedResponse.stream.toStringStream(),
            afterDisconnectedListener: (snapshot) {},
            afterDoneListener: (snapshot) {
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/room',
                  // Remove all screens below
                  (Route<dynamic> route) => false,
                  arguments: {
                    'roomOwner': widget.roomOwner,
                    'roomCode': widget.roomCode,
                  });
            },
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error!');
              }
              if (snapshot.hasData) {
                final data = Lobby.InterpretData(snapshot.data);
                if (data is List<String>) {
                  players.insertAll(0, data);
                }
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
            },
          );
        }
        return Text('');
      },
    );
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }
}
