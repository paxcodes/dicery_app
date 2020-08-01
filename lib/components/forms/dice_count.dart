import 'dart:math';
import 'package:flutter/material.dart';

import 'package:dicery/components/buttons/base_button.dart';
import 'package:dicery/components/number_picker.dart';
import 'package:dicery/components/dice_roll_result.dart';
import 'package:dicery/utilities/api.dart';

class DiceCountForm extends StatefulWidget {
  final String roomCode;
  final int maxDice = 6;
  final int minDice = 1;

  const DiceCountForm({Key key, @required this.roomCode}) : super(key: key);

  @override
  _DiceCountFormState createState() => _DiceCountFormState();
}

class _DiceCountFormState extends State<DiceCountForm> {
  int _diceCt = 1;
  List<int> _diceResults;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              '# of Dice',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 20,
            ),
            NumberPicker(
              initialValue: _diceCt,
              minValue: widget.minDice,
              maxValue: widget.maxDice,
              listViewHeight: 54,
              itemStyle: themeData.textTheme.bodyText1,
              selectedStyle: themeData.textTheme.headline5.copyWith(
                color: themeData.accentColor,
                fontWeight: FontWeight.bold,
              ),
              decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                border: Border.symmetric(
                  vertical: BorderSide(
                    color: themeData.primaryColor,
                    width: 0.5,
                  ),
                ),
              ),
              onChanged: (num number) {
                setState(() {
                  _diceCt = number;
                });
              },
              itemExtent: 60,
            ),
          ],
        ),
        SizedBox(height: 20),
        DiceryIconButton.primary(
          label: 'Roll Dice',
          iconData: Icons.refresh,
          onPressed: () {
            setState(() {
              _diceResults = _rollDice(_diceCt);
            });
            DiceryApi.sendDiceResults(_diceResults, widget.roomCode);
          },
        ),
        DiceRollResult(_diceResults),
      ],
    );
  }

  List<int> _rollDice(int diceCt) {
    final diceResults = [
      for (int i = 1; i <= diceCt; i++) Random().nextInt(6) + 1
    ];
    return diceResults;
  }
}
