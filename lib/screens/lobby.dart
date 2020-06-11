import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dicery/components/buttons/base_button.dart';
import 'package:dicery/components/player_card.dart';

class LobbyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, bool> args = ModalRoute.of(context).settings.arguments;
    final bool isOwnedByUser = args['isOwnedByUser'];

    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Column(
            children: [
              Text("Room F4K3R",
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: 50,
                        fontFamily: 'RobotoMono',
                        fontWeight: FontWeight.bold,
                      )),
              Text(
                "by Sean Williams",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 50),
              SizedBox(
                width: 380,
                child: TypewriterAnimatedTextKit(
                  text: ['waiting for other players'],
                  textStyle: Theme.of(context).textTheme.headline6.copyWith(
                        fontFamily: "RobotoMono",
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
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
              if (isOwnedByUser)
                DiceryIconButton.primary(
                  label: "Everyone's in",
                  onPressed: () {
                    Navigator.pushNamed(context, '/room');
                  },
                  iconData: Icons.forward,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
