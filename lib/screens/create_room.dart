import 'package:dicery/components/buttons/base_button.dart';
import 'package:dicery/utilities/api.dart';
import 'package:flutter/material.dart';
import 'package:dicery/styles.dart' as styles;

class CreateRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
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
        ),
      ),
    );
  }
}
