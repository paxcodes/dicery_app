import 'package:dicery/models/roll_entry.dart';
import 'package:dicery/utilities/player_colourizer.dart';
import 'package:flutter/material.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

class RollEntryListItem extends StatelessWidget {
  RollEntryListItem(this.rollEntry);
  final RollEntry rollEntry;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: ListTile(
        leading: SizedBox(
          width: 80,
          child: Text(
            rollEntry.player,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
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
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    wordSpacing: 15,
                    fontFamily: 'RobotoMono',
                  ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: themeData.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              padding: const EdgeInsets.all(6.0),
              child: Text(
                rollEntry.rolls.reduce((a, b) => a + b).toString(),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.bold,
                      color: themeData.backgroundColor,
                    ),
              ),
            ),
          ],
        ),
        subtitle: Timeago(
          builder: (_, value) => Text(
            value,
            style: TextStyle(fontSize: 12),
          ),
          date: rollEntry.date,
        ),
      ),
    );
  }
}
