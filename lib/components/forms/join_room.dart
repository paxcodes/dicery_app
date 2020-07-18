import 'package:flutter/material.dart';
import 'package:dicery/components/forms/name_field.dart';
import 'package:dicery/components/buttons/base_button.dart';

import 'package:dicery/styles.dart' as styles;

class JoinRoomForm extends StatefulWidget {
  const JoinRoomForm({Key key}) : super(key: key);

  @override
  _JoinRoomFormState createState() => _JoinRoomFormState();
}

class _JoinRoomFormState extends State<JoinRoomForm> {
  final _nameFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: styles.TextField.copyWith(hintText: 'Room ID'),
        ),
        SizedBox(height: 20),
        NameField(controller: _nameFieldController),
        SizedBox(height: 20),
        DiceryIconButton.primary(
          label: 'Join Room',
          iconData: Icons.group,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/lobby',
              // Clear navigation history
              (_) => false,
              arguments: <String, bool>{
                'isOwnedByUser': false,
              },
            );
          },
        )
      ],
    );
  }
}
