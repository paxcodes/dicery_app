import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:dicery/utilities/api.dart';

class Lobby {
  static const CLOSE_ROOM_COMMAND = '***CLOSE_ROOM***';

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

  /// Returns `List<String>` of new players.
  static List<String> InterpretData(String eventData) {
    eventData = eventData.trim();
    if (!eventData.startsWith('data: ')) {
      return [];
    }

    // TODO handle multiple data like
    // "data:SOMEDATA\r\n\ndata:SOMEDATAAGAIN\r\n\n"
    eventData = eventData.replaceFirst('data: ', '');
    return eventData.split(',');
  }
}
