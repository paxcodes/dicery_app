import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.create),
            label: Text("Create a Room"),
          ),
          SizedBox(height: 30),
          RaisedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            label: Text("Join a Room"),
          ),
        ],
      ),
    );
  }
}
