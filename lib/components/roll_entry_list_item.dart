import 'package:flutter/material.dart';
import 'package:dicery/models/roll_entry.dart';
import 'package:dicery/utilities/player_colourizer.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

class RollEntryListItem extends StatelessWidget {
  RollEntryListItem(this.rollEntry);
  final RollEntry rollEntry;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ListTile(
      leading: SizedBox(
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
      title: Wrap(
        spacing: 12,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text(
            rollEntry.rolls.join(' '),
            style: TextStyle(
              wordSpacing: 15,
              fontFamily: 'RobotoMono',
              fontSize: 20,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: themeData.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(3))),
            padding: const EdgeInsets.all(6.0),
            child: Text(
              rollEntry.rolls.reduce((a, b) => a + b).toString(),
              style: TextStyle(
                fontFamily: 'RobotoMono',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: themeData.backgroundColor,
              ),
            ),
          ),
        ],
      ),
      subtitle: Timeago(
        builder: (_, value) => Text(value),
        date: rollEntry.date,
      ),
    );
  }
}
