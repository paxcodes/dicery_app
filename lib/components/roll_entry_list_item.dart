import 'package:flutter/material.dart';
import 'package:dicery/models/roll_entry.dart';
import 'package:dicery/utilities/player_colourizer.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

class RollEntryListItem extends StatelessWidget {
  RollEntryListItem(this.rollEntry);
  final RollEntry rollEntry;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        // TODO set size dynamically. Otherwise, long player names
        // will be wrapped. OR we can set a character limit to
        // player names.
        width: 80,
        child: Text(
          rollEntry.player,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: PlayerColourizer.getTextColor(rollEntry.player),
          ),
        ),
      ),
      title: Text(
        rollEntry.rolls.join(' '),
        style: TextStyle(
          wordSpacing: 15,
          fontFamily: 'RobotoMono',
          fontSize: 20,
        ),
      ),
      subtitle: Timeago(
        builder: (_, value) => Text(value),
        date: rollEntry.date,
      ),
    );
  }
}
