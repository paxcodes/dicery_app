import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dicery/components/lobby_stream.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LobbyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final bool isOwnedByUser = args['isOwnedByUser'];
    final String roomOwner = args['roomOwner'];
    final String roomCode = args['roomCode'];

    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Column(
            children: [
              Text('Room $roomCode',
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontFamily: 'RobotoMono',
                        fontWeight: FontWeight.bold,
                      )),
              Text(
                'by $roomOwner',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 50),
              SizedBox(
                width: 380,
                child: TypewriterAnimatedTextKit(
                  text: ['waiting for other players'],
                  textStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontFamily: 'RobotoMono',
                        fontWeight: FontWeight.w300,
                      ),
                  speed: Duration(milliseconds: 100),
                  totalRepeatCount: -1,
                ),
              ),
              SizedBox(height: 20),
              LobbyStream(
                  roomCode: roomCode,
                  isOwnedByUser: isOwnedByUser,
                  roomOwner: roomOwner),
            ],
          ),
        ),
      ),
    );
  }
}
