import 'package:flutter/material.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({this.emoji, this.name});

  final String emoji;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
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
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              Text(name[0],
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                  )),
              Text(
                name.substring(1),
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
