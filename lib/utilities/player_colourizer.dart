import 'package:flutter/material.dart';
import 'dart:math';

class PlayerColourizer {
  static Map<String, Color> _players = {};
  static List<Color> _availableColors = [
    Colors.teal.shade400,
    Colors.teal.shade600,
    Colors.teal.shade800,
    Colors.blueGrey.shade500,
    Colors.blueGrey.shade700,
    Colors.blueGrey.shade900,
    Colors.green.shade700,
    Colors.green.shade900,
  ];

  static Color getColor(String player) {
    if (!_players.containsKey(player)) {
      _players[player] = _getAvailableColor();
    }
    return _players[player];
  }

  static Color _getAvailableColor() {
    final int randomIndex = Random().nextInt(_availableColors.length) + 1;
    return _availableColors.removeAt(randomIndex);
  }
}
