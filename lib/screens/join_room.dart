import 'package:dicery/components/buttons/base_button.dart';
import 'package:dicery/components/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:dicery/styles.dart' as Styles;

class JoinRoomScreen extends StatelessWidget {
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
              decoration: Styles.TextField.copyWith(hintText: "Room ID"),
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: Styles.TextField.copyWith(hintText: "Name"),
            ),
            SizedBox(height: 20),
            PrimaryDiceryButton(
              label: "Join Room",
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
        ),
      ),
    );
  }
}
