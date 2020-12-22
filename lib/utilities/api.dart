import 'dart:convert';
import 'dart:io';

import 'package:dicery/env/env.dart';
import 'package:dicery/models/room.dart';
import 'package:flutter/foundation.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:sse/client/sse_client.dart';

class DiceryApi {
  static String _cookie = '';
  static const String baseUrl = Env.apiUrl;
  static dynamic _client;

  DiceryApi() {
    if (kIsWeb) {
      _client = BrowserClient();
      _client.withCredentials = true;
    } else {
      _client = http.Client();
    }
  }

  void dispose() {
    _client.close();
  }

  /// Creates a room.
  ///
  /// Returns the room info: code, owner, isAvailable.
  Future<Room> createRoom(String roomOwner) async {
    final requestBody = {'room_owner': roomOwner};
    final requestUrl = '$baseUrl/rooms';
    final response = await _client.post(requestUrl, body: requestBody);

    if (!HttpHelper.isOk(response)) {
      throw OperationFailedException(
        response,
        plainMsg: '🛑 Something went wrong on our end. Try again later.',
      );
    }

    if (!kIsWeb) {
      // TODO store cookie in secure storage?
      var rawCookie = response.headers['set-cookie'];
      var index = rawCookie.indexOf(';');
      _cookie = (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
    return Room.fromJson(jsonDecode(response.body));
  }

  Future<Room> authenticate(String roomCode, String player) async {
    final requestBody = {'room_code': roomCode, 'player': player};
    final endpoint = 'token';
    final requestUrl = Uri.encodeFull('$baseUrl/$endpoint');
    final response = await _client.post(requestUrl, body: requestBody);

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

    if (!kIsWeb) {
      // TODO store cookie in secure storage?
      var rawCookie = response.headers['set-cookie'];
      var index = rawCookie.indexOf(';');
      _cookie = (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
    return Room.fromJson(jsonDecode(response.body));
  }

  dynamic joinLobby(String roomCode) async {
    final endpoint = 'lobby/$roomCode';
    final requestUrl = Uri.encodeFull('$baseUrl/$endpoint');
    if (!kIsWeb) {
      final request = http.Request('GET', Uri.parse(requestUrl));
      request.headers['Accept'] = 'text/event-stream';
      request.headers['Cookie'] = _cookie;
      return _client.send(request);
    }
    return SseClient(requestUrl);
  }

  Future<dynamic> subscribeToRoom(String roomCode) async {
    final endpoint = 'rooms/$roomCode';
    final requestUrl = Uri.encodeFull('$baseUrl/$endpoint');
    if (!kIsWeb) {
      final request = http.Request('GET', Uri.parse(requestUrl));
      request.headers['Cache-Control'] = 'no-cache';
      request.headers['Accept'] = 'text/event-stream';
      request.headers['Cookie'] = _cookie;
      return _client.send(request);
    }
    return SseClient(requestUrl);
  }

  Future<void> closeRoom(String roomCode) async {
    final endpoint = 'rooms/$roomCode/status/0';
    final requestUrl = '$baseUrl/$endpoint';
    final response = await _client.put(requestUrl);
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
