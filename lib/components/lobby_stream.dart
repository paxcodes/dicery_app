import 'dart:async';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:dicery/models/player_data.dart';
import 'package:dicery/utilities/api.dart';
import 'package:dicery/components/player_card.dart';

class LobbyStream extends StatefulWidget {
  final String roomCode;

  const LobbyStream({Key key, this.roomCode}) : super(key: key);

  @override
  _LobbyStreamState createState() => _LobbyStreamState();
}

class _LobbyStreamState extends State<LobbyStream> {
  final _client = http.Client();
  Future<http.StreamedResponse> streamedResponseFuture;

  @override
  void initState() {
    subscribe();
    super.initState();
  }

  void addPlayersFromData(String eventData, BuildContext context) {
    eventData = eventData.trim();
    if (!eventData.startsWith('data: ')) {
      return;
    }

    eventData = eventData.replaceFirst('data: ', '');
    final players = eventData.split(',');
    context.read<PlayerData>().addPlayers(players);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.StreamedResponse>(
      future: streamedResponseFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final streamedResponse = snapshot.data;
          return StreamBuilder<String>(
              stream: streamedResponse.stream.toStringStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error!');
                } else if (snapshot.hasData) {
                  addPlayersFromData(snapshot.data, context);
                  final players = context.watch<PlayerData>().players;
                  return ListView.builder(
                    itemCount: players.length,
                    itemBuilder: (context, index) =>
                        PlayerCard(emoji: '✨', name: players[index]),
                  );
                }
                return Text('');
              });
        }
        return Text('');
      },
    );
  }

  void subscribe() {
    print('Subscribing...');
    try {
      streamedResponseFuture = DiceryApi.joinLobby(_client, widget.roomCode);
    } catch (e) {
      print('Caught $e');
    }
  }

  void closeClient() {
    _client.close();
    print('Closed the client!');
  }

  @override
  void dispose() {
    closeClient();
    super.dispose();
  }
}
