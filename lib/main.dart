import 'package:dicery/screens/create_room.dart';
import 'package:dicery/screens/lobby.dart';
import 'package:dicery/utilities/api.dart';
import 'package:flutter/material.dart';
import 'package:dicery/screens/home.dart';
import 'package:dicery/screens/join_room.dart';
import 'package:dicery/screens/room.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(DiceryApp());
}

class DiceryApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DiceryApi>(
      create: (context) => DiceryApi(),
      dispose: (context, api) => api.dispose(),
      child: MaterialApp(
          title: 'Dicery',
          theme: ThemeData(
            textTheme: ThemeData.light().textTheme.copyWith(
                  bodyText1: TextStyle(
                    fontSize: 18,
                  ),
                ),
            backgroundColor: Color(0xffedf2f4),
            primaryColor: Color(0xFF2b2d42),
            accentColor: Color(0xFFD90429),
            // This makes the visual density adapt to the platform that you run
            // the app on. For desktop platforms, the controls will be smaller and
            // closer together (more dense) than on mobile platforms.
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => HomeScreen(),
            '/room': (context) => RoomScreen(),
            '/room/join': (context) => JoinRoomScreen(),
            '/room/create': (context) => CreateRoomScreen(),
            '/lobby': (context) => LobbyScreen(),
          }),
    );
  }
}
