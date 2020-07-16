import 'package:dicery/components/forms/name_field.dart';
import 'package:flutter/material.dart';

import 'package:dicery/components/buttons/base_button.dart';
import 'package:dicery/utilities/api.dart';

class CreateRoomForm extends StatefulWidget {
  const CreateRoomForm({
    Key key,
  }) : super(key: key);

  @override
  _CreateRoomFormState createState() => _CreateRoomFormState();
}

class _CreateRoomFormState extends State<CreateRoomForm> {
  final _nameFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        NameField(controller: _nameFieldController),
        SizedBox(height: 20),
        DiceryIconButton.primary(
          label: 'Create Room',
          iconData: Icons.group_add,
          onPressed: () async {
            final roomOwner = _nameFieldController.text.trim();
            if (roomOwner.isEmpty) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("🙅🏻‍♀️ Please enter a name that you'd like "
                      'to be identified with.'),
                ),
              );
            } else {
              final room = await DiceryApi.createRoom(roomOwner);
              await Navigator.pushNamedAndRemoveUntil(
                context,
                '/lobby',
                // Clear navigation history
                (_) => false,
                arguments: <String, dynamic>{
                  'isOwnedByUser': true,
                  'roomOwner': room.owner,
                  'roomCode': room.code
                },
              );
            }
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    _nameFieldController.dispose();
    super.dispose();
  }
}
