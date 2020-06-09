import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dicery/components/button.dart';
import 'package:dicery/components/player_card.dart';

class LobbyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Theme.of(context).accentColor,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Text("Room F4K3R",
                style: Theme.of(context).textTheme.headline1.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade100,
                    )),
            Text(
              "by Sean Williams",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 380,
              child: TypewriterAnimatedTextKit(
                text: ['Waiting for other players'],
                textStyle: Theme.of(context).textTheme.headline6,
                speed: Duration(milliseconds: 100),
                totalRepeatCount: -1,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: <Widget>[
                  PlayerCard(emoji: "💯", name: "Dakota"),
                  PlayerCard(emoji: "🎉", name: "Jordan"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
