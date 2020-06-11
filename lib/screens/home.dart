import 'package:dicery/components/buttons/base_button.dart';
import 'package:dicery/components/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PrimaryDiceryButton(
            label: "Create a Room",
            iconData: Icons.group_add,
            onPressed: () {
              Navigator.pushNamed(context, '/room/create');
            },
          ),
          SizedBox(height: 30),
          DiceryIconButton(
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
