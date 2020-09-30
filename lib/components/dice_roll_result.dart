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
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                ..._diceRolls.map(
                  (int num) => Padding(
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
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: themeData.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Text(_diceRolls.reduce((a, b) => a + b).toString(),
                      style: TextStyle(
                        fontFamily: 'RobotoMono',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: themeData.backgroundColor,
                      )),
                ),
              ],
            ),
    );
  }
}
