import 'package:dicery/components/button.dart';
import 'package:flutter/material.dart';

class LobbyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
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
            Text("by Sean Williams"),
            SizedBox(height: 50),
            Text("Waiting for other players..."),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Dakota joined the room! 🎉",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Jordan joined the room! 🎉",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
