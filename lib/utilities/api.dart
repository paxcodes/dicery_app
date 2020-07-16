import 'dart:convert';

import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

import 'package:dicery/models/room.dart';

class DiceryApi {
  static final String baseUrl = FlutterConfig.get('API_URL');

  /// Creates a room.
  ///
  /// Returns the room info: code, owner, isAvailable.
  static Future<Room> createRoom(String roomOwner) async {
    final requestBody = {'room_owner': roomOwner};
    final requestUrl = '$baseUrl/rooms';
    final response = await http.post(requestUrl, body: requestBody);
    if (!HttpHelper.isOk(response)) {
      throw OperationFailedException(
          'Failed creating room: ${response.statusCode} '
          '${response.reasonPhrase}');
    }
    return Room.fromJson(jsonDecode(response.body));
  }
}

class HttpHelper {
  static bool isOk(http.Response response) {
    return response.statusCode == 201 || response.statusCode == 200;
  }
}

class OperationFailedException implements Exception {
  final String message;

  OperationFailedException(this.message);
}
