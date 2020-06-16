import 'package:flutter/material.dart';
import 'package:dicery/models/roll_data.dart';
import 'package:dicery/components/roll_entry_list_item.dart';
import 'package:provider/provider.dart';

class DiceRollHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RollData>(
      builder: (context, rollData, child) => ListView.builder(
        itemCount: rollData.rollEntries.length,
        itemBuilder: (context, index) =>
            RollEntryListItem(rollData.rollEntries[index]),
      ),
    );
  }
}
