import 'dart:collection';

import 'package:dicery/models/roll_entry.dart';
import 'package:flutter/cupertino.dart';

class RollData extends ChangeNotifier {
  List<RollEntry> _rollEntries = [
    RollEntry(
        player: "Dakota",
        rolls: [1, 2, 3, 4, 14],
        date: DateTime(2020, 1, 2, 6, 1)),
    RollEntry(
        player: "Jordan",
        rolls: [1, 2, 2, 3, 3],
        date: DateTime(2020, 1, 2, 6, 31)),
    RollEntry(
        player: "Jordan",
        rolls: [6, 2, 3, 4],
        date: DateTime(2020, 1, 2, 6, 33)),
    RollEntry(player: "Dakota", rolls: [6], date: DateTime(2020, 1, 2, 6, 35)),
  ];

  UnmodifiableListView<RollEntry> get rollEntries =>
      UnmodifiableListView(_rollEntries);
}
