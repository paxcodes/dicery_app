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
  final _formKey = GlobalKey<FormState>();
  final _nameFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: styles.TextField.copyWith(
              hintText: 'Room ID',
              helperText: ' ',
            ),
            validator: (value) =>
                value.isEmpty ? 'Please enter the room ID.' : null,
          ),
          SizedBox(height: 15),
          NameField(controller: _nameFieldController),
          SizedBox(height: 20),
          DiceryIconButton.primary(
            label: 'Join Room',
            iconData: Icons.group,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Joining room ✨'),
                  ),
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/lobby',
                  // Clear navigation history
                  (_) => false,
                  arguments: <String, bool>{
                    'isOwnedByUser': false,
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }
}
