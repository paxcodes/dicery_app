import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:dicery/utilities/api.dart';

class Lobby {
  static Future<http.StreamedResponse> Subscribe(
      http.Client client, String roomCode) {
    var streamedResponseFuture;
    try {
      streamedResponseFuture = DiceryApi.joinLobby(client, roomCode);
    } catch (e) {
      print('Caught $e');
    }
    return streamedResponseFuture;
  }

  static List<String> GetPlayersFromData(String eventData) {
    eventData = eventData.trim();
    if (!eventData.startsWith('data: ')) {
      return [];
    }

    eventData = eventData.replaceFirst('data: ', '');
    return eventData.split(',');
  }
}
