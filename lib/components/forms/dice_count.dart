import 'package:dicery/components/buttons/base_button.dart';
import 'package:dicery/components/number_picker.dart';
import 'package:dicery/models/roll_data.dart';
import 'package:dicery/models/roll_entry.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class DiceCountForm extends StatefulWidget {
  final int maxDice = 6;
  final int minDice = 1;

  const DiceCountForm({
    Key key,
  }) : super(key: key);

  @override
  _DiceCountFormState createState() => _DiceCountFormState();
}

class _DiceCountFormState extends State<DiceCountForm> {
  int _diceCt = 6;

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
            final diceResults = _rollDice(_diceCt);
            context.read<RollData>().lastRoll = diceResults;
            context.read<RollData>().addRollEntry(RollEntry(
                  player: 'Pax',
                  rolls: diceResults,
                  date: DateTime.now(),
                ));
          },
        ),
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
