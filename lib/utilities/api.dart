import 'dart:convert';

import 'package:http/http.dart' as http;

class DiceryApi {
  static const String baseUrl = 'http://localhost:8000';

  /// Creates a room.
  ///
  /// TODO Throws an error if creation is not successful.
  /// Returns the code for the created room.
  static Future<dynamic> createRoom(String roomOwner) async {
    final requestBody = {'room_owner': roomOwner};
    final requestUrl = '$baseUrl/rooms';
    final response = await http.post(requestUrl, body: requestBody);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
