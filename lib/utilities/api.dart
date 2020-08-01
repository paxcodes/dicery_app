import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

import 'package:dicery/models/room.dart';

class DiceryApi {
  static final String baseUrl = FlutterConfig.get('API_URL');
  static String _cookie = '';

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

    // TODO store cookie in secure storage?
    var rawCookie = response.headers['set-cookie'];
    var index = rawCookie.indexOf(';');
    _cookie = (index == -1) ? rawCookie : rawCookie.substring(0, index);
    return Room.fromJson(jsonDecode(response.body));
  }

  static Future<Room> authenticate(String roomCode, String player) async {
    final requestBody = {'room_code': roomCode, 'player': player};
    final endpoint = 'token';
    final requestUrl = Uri.encodeFull('$baseUrl/$endpoint');
    final response = await http.post(requestUrl, body: requestBody);

    if (response.statusCode == HttpStatus.forbidden ||
        response.statusCode == HttpStatus.notFound) {
      throw OperationFailedException(
        response,
        plainMsg: '⚠️ Cannot join Room $roomCode. Are you sure you entered '
            'the correct room code?',
      );
    }

    if (HttpHelper.isNotOk(response)) {
      throw OperationFailedException(
        response,
        plainMsg: '🛑 Something went wrong on our end. Try again later.',
      );
    }

    // TODO store cookie in Secure Storage?
    var rawCookie = response.headers['set-cookie'];
    var index = rawCookie.indexOf(';');
    _cookie = (index == -1) ? rawCookie : rawCookie.substring(0, index);
    return Room.fromJson(jsonDecode(response.body));
  }

  static Future<http.StreamedResponse> joinLobby(
      http.Client client, String roomCode) async {
    final endpoint = 'lobby/$roomCode';
    final request =
        http.Request('GET', Uri.parse(Uri.encodeFull('$baseUrl/$endpoint')));
    request.headers['Cache-Control'] = 'no-cache';
    request.headers['Accept'] = 'text/event-stream';
    request.headers['Cookie'] = _cookie;
    return client.send(request);
  }

  static Future<void> closeRoom(String roomCode) async {
    final endpoint = 'rooms/$roomCode/status/0';
    final requestUrl = '$baseUrl/$endpoint';
    final headers = {'cookie': _cookie};
    final response = await http.put(requestUrl, headers: headers);
    if (response.statusCode == HttpStatus.forbidden) {
      throw OperationFailedException(
        response,
        plainMsg: '🛑 You are not authorized to close the room.',
      );
    }

    if (response.statusCode == HttpStatus.notFound) {
      throw OperationFailedException(
        response,
        plainMsg: '🛑 Room does not exist or already closed.',
      );
    }
  }

  static Future<void> sendDiceResults(
      List<int> _diceResults, String roomCode) async {
    final endpoint = 'rolls/$roomCode';
    final requestUrl = '$baseUrl/$endpoint';
    final requestBody = {'diceRolls': _diceResults.join(',')};
    final headers = {'cookie': _cookie};
    final response =
        await http.post(requestUrl, body: requestBody, headers: headers);
    if (response.statusCode == HttpStatus.forbidden) {
      throw OperationFailedException(
        response,
        plainMsg: '🛑 You are not a member of this room.',
      );
    }

    if (response.statusCode == HttpStatus.notFound) {
      throw OperationFailedException(
        response,
        plainMsg: '🛑 Room does not exist.',
      );
    }
  }
}

class HttpHelper {
  static bool isOk(http.Response response) {
    return response.statusCode == 201 || response.statusCode == 200;
  }

  static bool isNotOk(http.Response response) {
    return !HttpHelper.isOk(response);
  }
}

class OperationFailedException implements Exception {
  final String geekyMsg;
  final String plainMsg;

  OperationFailedException(http.Response response, {@required this.plainMsg})
      : geekyMsg = '${response.request.method} ${response.request.url.path}: '
            '${response.statusCode} ${response.reasonPhrase}';
}
