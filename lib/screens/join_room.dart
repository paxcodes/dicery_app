import 'package:flutter/material.dart';
import 'package:dicery/components/forms/join_room.dart';

class JoinRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: JoinRoomForm(),
      ),
    );
  }
}
