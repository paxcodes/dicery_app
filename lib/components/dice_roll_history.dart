import 'package:flutter/material.dart';
import 'package:dicery/models/roll_entry.dart';
import 'package:dicery/components/roll_entry_list_item.dart';

class DiceRollHistory extends StatelessWidget {
  final List<RollEntry> _rolls = [
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _rolls.length,
      itemBuilder: (context, index) => RollEntryListItem(_rolls[index]),
    );
  }
}
