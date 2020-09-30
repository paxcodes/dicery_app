import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dicery/components/forms/name_field.dart';
import 'package:dicery/components/buttons/base_button.dart';
import 'package:dicery/styles.dart' as styles;
import 'package:dicery/utilities/api.dart';

class JoinRoomForm extends StatefulWidget {
  const JoinRoomForm({Key key}) : super(key: key);

  @override
  _JoinRoomFormState createState() => _JoinRoomFormState();
}

class _JoinRoomFormState extends State<JoinRoomForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameFieldController = TextEditingController();
  final _roomFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _roomFieldController,
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
            onPressed: () async {
              if (!_formKey.currentState.validate()) {
                return;
              }

              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Joining room ✨'),
                ),
              );

              final roomCode = _roomFieldController.text.trim();
              final player = _nameFieldController.text.trim();

              var room;
              try {
                room = await DiceryApi.authenticate(roomCode, player);
              } on OperationFailedException catch (e) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.plainMsg),
                  ),
                );
              }
              if (room != null) {
                await Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/lobby',
                  // Clear navigation history
                  (_) => false,
                  arguments: <String, dynamic>{
                    'isOwnedByUser': false,
                    'roomCode': room.code,
                    'roomOwner': room.owner
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _roomFieldController.dispose();
    _nameFieldController.dispose();
    super.dispose();
  }
}
