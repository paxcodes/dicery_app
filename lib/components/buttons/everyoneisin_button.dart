import 'package:dicery/components/buttons/base_button.dart';
import 'package:dicery/utilities/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final api = context.watch<DiceryApi>();

    return DiceryIconButton.primary(
      label: "Everyone's in",
      onPressed: playerCount > 1 ? () => api.closeRoom(roomCode) : null,
      iconData: Icons.forward,
    );
  }
}
