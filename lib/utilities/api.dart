import 'dart:convert';

import 'package:meta/meta.dart';
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
    final endpoint = 'rooms';
    final requestUrl = '$baseUrl/$endpoint';
    final response = await http.post(requestUrl, body: requestBody);
    if (!HttpHelper.isOk(response)) {
      throw OperationFailedException(
        response,
        plainMsg: '🛑 Something went wrong on our end. Try again later.',
      );
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
  final String geekyMsg;
  final String plainMsg;

  OperationFailedException(http.Response response, {@required this.plainMsg})
      : geekyMsg = '${response.request.method} ${response.request.url.path}: '
            '${response.statusCode} ${response.reasonPhrase}';
}
