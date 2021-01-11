import 'package:flutter/material.dart';
import 'package:dicery/components/forms/dice_count.dart';
import 'package:dicery/components/dice_roll_history.dart';

class RoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, String> args = ModalRoute.of(context).settings.arguments;
    final roomOwner = args['roomOwner'];
    final roomCode = args['roomCode'];

    return Material(
      child: Container(
        padding: EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Text(
                'Room $roomCode',
                style: Theme.of(context).textTheme.headline1.copyWith(
                      fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'by $roomOwner',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 50),
              DiceCountForm(roomCode: roomCode),
              Expanded(child: DiceRollHistory(roomCode: roomCode)),
            ],
          ),
        ),
      ),
    );
  }
}
