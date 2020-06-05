import 'package:flutter/material.dart';
import 'package:dicery/styles.dart' as Styles;

class JoinRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Padding(
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
          ],
        ),
      ),
    );
  }
}
