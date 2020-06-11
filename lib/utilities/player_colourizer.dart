import 'package:flutter/material.dart';
import 'dart:math';

class PlayerColourizer {
  static Map<String, Color> _players = {};
  static List<Color> _availableColors = [
    Color(0xFF2b2d42),
    Color(0xFF51547B),
    Colors.blueGrey.shade700,
    Colors.blueGrey.shade900,
    Colors.blueGrey.shade900,
  ];

  static Color getTextColor(String player) {
    if (!_players.containsKey(player)) {
      _players[player] = _getAvailableColor();
    }
    return _players[player];
  }

  static Color _getAvailableColor() {
    int colorIndex = _players.length % _availableColors.length;
    return _availableColors[colorIndex];
  }
}
