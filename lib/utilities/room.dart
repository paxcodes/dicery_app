import 'package:dicery/models/roll_entry.dart';
import 'package:dicery/utilities/api.dart';
import 'package:http/http.dart' as http;

class Room {
  static Future<dynamic> Subscribe(api, String roomCode) async {
    var streamedResponseFuture;
    try {
      streamedResponseFuture = api.subscribeToRoom(roomCode);
    } catch (e) {
      print('Caught $e');
    }
    return streamedResponseFuture;
  }

  /// Returns a `RollEntry` if eventData is a roll entry
  /// Otherwise, null.
  static dynamic InterpretData(String eventData) {
    eventData = eventData.trim();
    if (!eventData.startsWith('data: ')) {
      return;
    }

    // TODO Handle multiple data, e.g.
    // "data: SOMEDATA\r\n\ndata:SOMEDATAAGAIN\r\n\n"
    // final diceRollEntries = eventData.split('\r\n\n');
    // for ()

    eventData = eventData.replaceFirst('data: ', '');
    final diceRollEntry = eventData.split('|');
    return RollEntry(
      player: diceRollEntry[0],
      rolls: diceRollEntry[1].split(',').map(int.parse).toList(),
      date: DateTime.parse(diceRollEntry[2]),
    );
  }
}
