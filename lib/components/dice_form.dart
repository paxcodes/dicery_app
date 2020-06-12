import 'package:dicery/components/buttons/base_button.dart';
import 'package:dicery/components/number_picker.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DiceForm extends StatefulWidget {
  final int maxDice = 6;
  final int minDice = 1;

  const DiceForm({
    Key key,
  }) : super(key: key);

  @override
  _DiceFormState createState() => _DiceFormState();
}

class _DiceFormState extends State<DiceForm> {
  int _diceCt = 6;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "# of Dice",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            NumberPicker(
              initialValue: _diceCt,
              minValue: widget.minDice,
              maxValue: widget.maxDice,
              onChanged: (num number) {
                print(number);
                setState(() {
                  _diceCt = number;
                });
              },
              itemExtent: 80,
            ),
          ],
        ),
        DiceryIconButton.primary(
          label: "Roll Dice",
          iconData: Icons.refresh,
          onPressed: () {
            rollDice(_diceCt);
          },
        ),
      ],
    );
  }

  void rollDice(int diceCt) {
    List<int> diceRolls = [
      for (int i = 1; i <= diceCt; i++) Random().nextInt(6) + 1
    ];
    print(diceRolls);
  }
}
