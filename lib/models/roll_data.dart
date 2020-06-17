import 'dart:collection';

import 'package:dicery/models/roll_entry.dart';
import 'package:flutter/cupertino.dart';

class RollData extends ChangeNotifier {
  static final DateTime now = DateTime.now();
  List<int> _lastRoll;
  final List<RollEntry> _rollEntries = [
    RollEntry(
        player: 'Dakota',
        rolls: [1, 2, 3, 4, 14],
        date: now.subtract(Duration(minutes: 2))),
    RollEntry(
        player: 'Jordan',
        rolls: [6, 2, 3, 4],
        date: now.subtract(Duration(minutes: 5))),
    RollEntry(
        player: 'Dakota', rolls: [6], date: now.subtract(Duration(minutes: 6))),
  ];

  List<int> get lastRoll => _lastRoll;
  set lastRoll(roll) {
    _lastRoll = roll;
    notifyListeners();
  }

  void addRollEntry(RollEntry newRollEntry) {
    _rollEntries.insert(0, newRollEntry);
    notifyListeners();
  }

  UnmodifiableListView<RollEntry> get rollEntries =>
      UnmodifiableListView(_rollEntries);
}
