import 'package:dicery/components/dice_roll_history.dart';
import 'package:dicery/components/forms/dice_count.dart';
import 'package:dicery/models/room.dart';
import 'package:dicery/utilities/api.dart';
import 'package:flutter/material.dart';

class RoomScreen extends StatefulWidget {
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  String roomOwner;
  String roomCode;
  Future<Room> futureRoom;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> args = ModalRoute.of(context).settings.arguments;
    if (args == null) {
      var api = DiceryApi();
      return FutureBuilder(
        future: api.verifyToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('Something went wrong. 🤷🏻‍♀️');
            }
            Room room = snapshot.data;
            return RoomLayout(roomCode: room.code, roomOwner: room.owner);
          } else {
            return CircularProgressIndicator();
          }
        },
      );
    }
    return RoomLayout(roomCode: args['roomCode'], roomOwner: args['roomOwner']);
  }
}

class RoomLayout extends StatelessWidget {
  const RoomLayout({
    Key key,
    @required this.roomCode,
    @required this.roomOwner,
  }) : super(key: key);

  final String roomCode;
  final String roomOwner;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Text(
                'Room $roomCode',
                style: Theme.of(context).textTheme.headline1.copyWith(
                      fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'by $roomOwner',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 50),
              DiceCountForm(roomCode: roomCode),
              Expanded(child: DiceRollHistory(roomCode: roomCode)),
            ],
          ),
        ),
      ),
    );
  }
}
