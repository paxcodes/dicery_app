import 'package:dicery/models/roll_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiceRollResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<int> diceRolls = context.watch<RollData>().lastRoll;
    final themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: diceRolls == null
          ? Center(
              child: Text(
              "You have not rolled yet.",
              style: themeData.textTheme.bodyText1,
            ))
          : Wrap(
              children: <Widget>[
                ...diceRolls.map((int num) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        num.toString(),
                        style: TextStyle(
                          fontFamily: "RobotoMono",
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: num == 1
                              ? themeData.accentColor
                              : themeData.primaryColor,
                        ),
                      ),
                    ))
              ],
            ),
    );
  }
}
