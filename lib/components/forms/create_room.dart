import 'package:flutter/material.dart';

import 'package:dicery/components/buttons/base_button.dart';
import 'package:dicery/utilities/api.dart';
import 'package:dicery/styles.dart' as styles;
import 'package:flutter/services.dart';

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
        TextField(
          maxLength: 16,
          maxLengthEnforced: true,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter(RegExp(r'[a-zA-Z0-9]'))
          ],
          controller: _nameFieldController,
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
            final roomOwner = _nameFieldController.text.trim();
            if (roomOwner.isEmpty) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Please enter a name that you'd like "
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
