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
            iconData: Icons.create,
            onPressed: () {
              print("Create a room!");
            },
          ),
          SizedBox(height: 30),
          DiceryIconButton(
            onPressed: () {},
            iconData: Icons.add,
            label: "Join a Room",
          ),
        ],
      ),
    );
  }
}
