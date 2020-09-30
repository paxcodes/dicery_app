import 'dart:async';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:dicery/components/roll_entry_list_item.dart';
import 'package:dicery/models/roll_entry.dart';
import 'package:dicery/utilities/room.dart';

class DiceRollHistory extends StatefulWidget {
  final String roomCode;
  DiceRollHistory({@required this.roomCode});

  @override
  _DiceRollHistoryState createState() => _DiceRollHistoryState();
}

class _DiceRollHistoryState extends State<DiceRollHistory>
    with WidgetsBindingObserver {
  final _client = http.Client();
  final List<RollEntry> _rollEntries = [];
  bool _streamHasError = false;
  StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    streamDiceRolls();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _streamSubscription.pause();
    } else if (state == AppLifecycleState.resumed) {
      _streamSubscription.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_streamHasError) {
      return Expanded(child: Text('Error!'));
    }

    return _rollEntries.isEmpty
        ? Text(
            'No one has rolled the dice yet.',
            style: TextStyle(fontStyle: FontStyle.italic),
          )
        : ListView.builder(
            itemCount: _rollEntries.length,
            itemBuilder: (context, index) =>
                RollEntryListItem(_rollEntries[index]),
          );
  }

  @override
  void dispose() {
    _client.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void streamDiceRolls() async {
    var response = await Room.Subscribe(_client, widget.roomCode);
    var stream = response.stream.toStringStream();
    _streamSubscription = stream.listen(
      (newData) {
        final data = Room.InterpretData(newData);
        if (data is RollEntry) {
          setState(() {
            _rollEntries.insert(0, data);
          });
        }
      },
      onDone: exitRoom,
      onError: (err) => setState(() => _streamHasError = true),
    );
  }

  void exitRoom() {
    // TODO Navigate to an "If you enjoyed using the app,"
    // consider giving the developer a "tip".
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      // Remove all screens below.
      (route) => false,
    );
  }
}
