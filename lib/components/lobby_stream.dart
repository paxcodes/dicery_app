import 'dart:async';
import 'package:dicery/utilities/api.dart';

import 'package:flutter/material.dart';
import 'package:dicery/components/player_card.dart';

import 'package:http/http.dart' as http;

class LobbyStream extends StatefulWidget {
  final String roomCode;

  const LobbyStream({Key key, this.roomCode}) : super(key: key);

  @override
  _LobbyStreamState createState() => _LobbyStreamState();
}

class _LobbyStreamState extends State<LobbyStream> {
  final _client = http.Client();
  Future<http.StreamedResponse> streamedResponseFuture;
  final _playerCards = [];

  @override
  void initState() {
    subscribe();
    super.initState();
  }

  String extractData(String eventData) {
    eventData = eventData.trim();
    if (eventData.startsWith('data: ')) {
      eventData = eventData.replaceFirst('data: ', '');
    } else {
      eventData = '';
    }
    return eventData;
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
                  final data = extractData(snapshot.data);
                  if (data != '') {
                    _playerCards.add(PlayerCard(emoji: '💯', name: data));
                  }
                  return ListView.builder(
                      itemCount: _playerCards.length,
                      itemBuilder: (context, index) => _playerCards[index]);
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
