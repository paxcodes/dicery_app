import 'package:flutter/material.dart';

import 'package:dicery/components/roll_entry_list_item.dart';
import 'package:dicery/models/roll_entry.dart';

class DiceRollHistory extends StatelessWidget {
  static final DateTime now = DateTime.now();
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _rollEntries.length,
      itemBuilder: (context, index) => RollEntryListItem(_rollEntries[index]),
    );
  }
}
