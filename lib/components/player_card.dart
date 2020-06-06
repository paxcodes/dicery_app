import 'package:flutter/material.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({this.emoji, this.name});

  final String emoji;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Text(
            emoji,
            style: TextStyle(
              fontSize: 35,
            ),
          ),
        ),
        title: Row(
          children: <Widget>[
            Text(name[0],
                style: TextStyle(
                  backgroundColor: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                  color: Colors.teal.shade900,
                )),
            Text(
              name.substring(1),
              style: TextStyle(
                fontSize: 35,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
