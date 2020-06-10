import 'package:flutter/material.dart';
import 'package:dicery/components/dice_form.dart';
import 'package:dicery/components/dice_roll_result.dart';
import 'package:dicery/components/dice_roll_history.dart';

class RoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.tealAccent.shade100,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Text("Room F4K3R",
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: 50,
                        fontFamily: 'RobotoMono',
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade900,
                      )),
              Text(
                "by Sean Williams",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.teal.shade900),
              ),
              SizedBox(height: 50),
              DiceForm(),
              DiceRollResult(),
              DiceRollHistory(),
            ],
          ),
        ),
      ),
    );
  }
}
