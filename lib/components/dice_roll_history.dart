import 'package:flutter/material.dart';

import 'package:dicery/components/roll_entry_list_item.dart';
import 'package:dicery/models/roll_entry.dart';

class DiceRollHistory extends StatelessWidget {
  static final DateTime now = DateTime.now();
  final List<RollEntry> _rollEntries = [];

  @override
  Widget build(BuildContext context) {
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
}
