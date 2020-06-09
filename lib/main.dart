import 'package:dicery/screens/create_room.dart';
import 'package:dicery/screens/lobby.dart';
import 'package:flutter/material.dart';
import 'package:dicery/screens/home.dart';
import 'package:dicery/screens/join_room.dart';
import 'package:dicery/screens/room.dart';

void main() {
  runApp(DiceryApp());
}

class DiceryApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Dicery',
        theme: ThemeData(
          iconTheme: IconThemeData(color: Colors.teal.shade900),
          backgroundColor: Colors.tealAccent[100],
          primarySwatch: Colors.teal,
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
        });
  }
}
