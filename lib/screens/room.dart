import 'package:dicery/models/roll_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dicery/components/dice_form.dart';
import 'package:dicery/components/dice_roll_result.dart';
import 'package:dicery/components/dice_roll_history.dart';

class RoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RollData>(
      create: (context) => RollData(),
      child: Material(
        child: Container(
          padding: EdgeInsets.all(16),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Text("Room F4K3R",
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: 50,
                        fontFamily: 'RobotoMono',
                        fontWeight: FontWeight.bold)),
                Text(
                  "by Sean Williams",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: 50),
                DiceForm(),
                Expanded(flex: 1, child: DiceRollResult()),
                Expanded(flex: 2, child: DiceRollHistory()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
