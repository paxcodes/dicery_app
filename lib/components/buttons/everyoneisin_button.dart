import 'package:flutter/material.dart';

import 'package:dicery/components/buttons/base_button.dart';

class EveryonesInButton extends StatelessWidget {
  EveryonesInButton({
    Key key,
    @required this.playerCount,
    @required this.roomOwner,
    @required this.roomCode,
  }) : super(key: key);

  final String roomOwner;
  final String roomCode;
  final int playerCount;

  @override
  Widget build(BuildContext context) {
    return DiceryIconButton.primary(
      label: "Everyone's in",
      onPressed: playerCount > 1
          ? () {
              Navigator.pushNamed(context, '/room', arguments: {
                'roomOwner': roomOwner,
                'roomCode': roomCode,
              });
            }
          : null,
      iconData: Icons.forward,
    );
  }
}
