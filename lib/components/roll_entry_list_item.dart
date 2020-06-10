import 'package:flutter/material.dart';
import 'package:dicery/models/roll_entry.dart';
import 'package:dicery/utilities/player_colourizer.dart';

class RollEntryListItem extends StatelessWidget {
  RollEntryListItem(this.rollEntry);
  final RollEntry rollEntry;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        rollEntry.player,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: PlayerColourizer.getColor(rollEntry.player),
        ),
      ),
      title: Text(
        rollEntry.rolls.join(" "),
        style: TextStyle(
          wordSpacing: 15,
          fontFamily: 'RobotoMono',
          fontSize: 20,
        ),
      ),
      subtitle: Text(rollEntry.date.toIso8601String()),
    );
  }
}
