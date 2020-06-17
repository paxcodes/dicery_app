import 'package:flutter/material.dart';

import 'package:dicery/components/buttons/base_button.dart';
import 'package:dicery/utilities/api.dart';
import 'package:dicery/styles.dart' as styles;

class CreateRoomForm extends StatefulWidget {
  const CreateRoomForm({
    Key key,
  }) : super(key: key);

  @override
  _CreateRoomFormState createState() => _CreateRoomFormState();
}

class _CreateRoomFormState extends State<CreateRoomForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: styles.TextField.copyWith(hintText: 'Your Name'),
        ),
        SizedBox(height: 20),
        DiceryIconButton.primary(
          label: 'Create Room',
          iconData: Icons.group_add,
          onPressed: () async {
            final roomOwner = 'Hunka Wonka';
            final String roomCode = await DiceryApi.createRoom(roomOwner);
            await Navigator.pushNamedAndRemoveUntil(
              context,
              '/lobby',
              // Clear navigation history
              (_) => false,
              arguments: <String, dynamic>{
                'isOwnedByUser': true,
                'roomOwner': roomOwner,
                'roomCode': roomCode
              },
            );
          },
        )
      ],
    );
  }
}
