import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dicery/models/roll_entry.dart';

class DiceRollHistory extends StatelessWidget {
  final List<RollEntry> _rolls = [
    RollEntry(
        player: "Dakota",
        rolls: [1, 2, 3, 4],
        date: DateTime(2020, 1, 2, 6, 1)),
    RollEntry(
        player: "Jordan",
        rolls: [1, 2, 2, 3, 3],
        date: DateTime(2020, 1, 2, 6, 31)),
    RollEntry(
        player: "Jordan",
        rolls: [6, 2, 3, 4],
        date: DateTime(2020, 1, 2, 6, 33)),
    RollEntry(player: "Dakota", rolls: [6], date: DateTime(2020, 1, 2, 6, 35)),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _rolls.length,
        itemBuilder: (context, index) => ListTile(
          leading: Text(
            _rolls[index].player,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: PlayerColourizer.getColor(_rolls[index].player),
            ),
          ),
          title: Text(_rolls[index].rolls.toString()),
          subtitle: Text(_rolls[index].date.toIso8601String()),
        ),
      ),
    );
  }
}

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
