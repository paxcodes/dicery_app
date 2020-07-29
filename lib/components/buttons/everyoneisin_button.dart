import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dicery/models/player_data.dart';
import 'package:dicery/components/buttons/base_button.dart';

class EveryonesInButton extends StatelessWidget {
  const EveryonesInButton({
    Key key,
    @required this.roomOwner,
    @required this.roomCode,
  }) : super(key: key);

  final String roomOwner;
  final String roomCode;

  @override
  Widget build(BuildContext context) {
    final players = context.watch<PlayerData>().players;

    return DiceryIconButton.primary(
      label: "Everyone's in",
      onPressed: players.length > 1
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
