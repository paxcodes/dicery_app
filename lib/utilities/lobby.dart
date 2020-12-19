import 'dart:async';

import 'package:flutter/foundation.dart';

class Lobby {
  static const CLOSE_ROOM_COMMAND = '***CLOSE_ROOM***';

  static Future<dynamic> Subscribe(api, String roomCode) {
    var streamedResponseFuture;
    try {
      streamedResponseFuture = api.joinLobby(roomCode);
    } catch (e) {
      print('Caught $e');
    }
    return streamedResponseFuture;
  }

  /// Returns `List<String>` of new players.
  static List<String> InterpretData(String eventData) {
    if (!kIsWeb) {
      eventData = eventData.trim();
      if (!eventData.startsWith('data: ')) {
        return [];
      }
      // TODO handle multiple data like
      // "data:SOMEDATA\r\n\ndata:SOMEDATAAGAIN\r\n\n"
      eventData = eventData.replaceFirst('data: ', '');
    }

    return eventData.split(',');
  }
}
