import 'package:flutter/material.dart';

class DiceRollResult extends StatelessWidget {
  final List<int> _diceRolls;

  DiceRollResult(this._diceRolls);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: _diceRolls == null
          ? Center(
              child: Text(
              'You have not rolled yet.',
              style: themeData.textTheme.bodyText1,
            ))
          : Wrap(
              children: <Widget>[
                ..._diceRolls.map((int num) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        num.toString(),
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
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
