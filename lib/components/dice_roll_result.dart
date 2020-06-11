import 'package:flutter/material.dart';

class DiceRollResult extends StatelessWidget {
  final List<int> diceRolls = [
    1,
    5,
    3,
    6,
    2,
    1,
    3,
    6,
    2,
    1,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Wrap(
        children: <Widget>[
          ...diceRolls.map((int num) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  num.toString(),
                  style: TextStyle(
                    fontFamily: "RobotoMono",
                    fontSize: 30,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
