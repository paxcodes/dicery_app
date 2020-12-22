import 'dart:async';

import 'package:dicery/components/roll_entry_list_item.dart';
import 'package:dicery/models/roll_entry.dart';
import 'package:dicery/utilities/api.dart';
import 'package:dicery/utilities/room.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DiceRollHistory extends StatefulWidget {
  final String roomCode;
  DiceRollHistory({@required this.roomCode});

  @override
  _DiceRollHistoryState createState() => _DiceRollHistoryState();
}

class _DiceRollHistoryState extends State<DiceRollHistory>
    with WidgetsBindingObserver {
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
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void streamDiceRolls() async {
    var api = DiceryApi();
    var channel = await Room.Subscribe(api, widget.roomCode);
    var stream = (kIsWeb) ? channel.stream : channel.stream.toStringStream();
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
