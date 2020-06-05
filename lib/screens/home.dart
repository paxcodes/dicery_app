import 'package:dicery/components/button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DiceryIconButton(
            label: "Create a Room",
            iconData: Icons.group_add,
            onPressed: () {
              Navigator.pushNamed(context, '/room/create');
            },
          ),
          SizedBox(height: 30),
          DiceryIconButton(
            isPrimary: false,
            onPressed: () {
              Navigator.pushNamed(context, '/room/join');
            },
            iconData: Icons.group,
            label: "Join a Room",
          ),
        ],
      ),
    );
  }
}
