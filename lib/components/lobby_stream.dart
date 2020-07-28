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
  final _playerCards = [
    PlayerCard(emoji: '💯', name: 'Dakota'),
    PlayerCard(emoji: '🎉', name: 'Jordan')
  ];

  @override
  void initState() {
    subscribe();
    super.initState();
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
                  _playerCards
                      .add(PlayerCard(emoji: '💯', name: snapshot.data));
                  return ListView.builder(
                      itemBuilder: (context, index) => _playerCards[index]);
                }
                return Text('');
              });
        }
        return Text('');
      },
    );
  }

  void subscribe() async {
    print('Subscribing...');
    try {
      var resp = await DiceryApi.joinLobby(widget.roomCode);
      print('API HAS RESPONDED!!! $resp');
//      final request = http.Request(
//          'GET', Uri.parse('http://dicery-staging.margret.pw/lobby/F4K3R00M'));
//      request.headers['Cache-Control'] = 'no-cache';
//      request.headers['Accept'] = 'text/event-stream';
//
//      streamedResponseFuture = _client.send(request);
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
