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

class _DiceRollHistoryState extends State<DiceRollHistory> {
  final _client = http.Client();
  Future<http.StreamedResponse> streamedResponseFuture;
  final List<RollEntry> _rollEntries = [];

  @override
  void initState() {
    streamedResponseFuture = Room.Subscribe(_client, widget.roomCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.StreamedResponse>(
      future: streamedResponseFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final streamedResponse = snapshot.data;
          return StreamBuilder<String>(
            stream: streamedResponse.stream.toStringStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error!');
              } else if (snapshot.hasData) {
                final data = Room.InterpretData(snapshot.data);
                if (data is RollEntry) {
                  _rollEntries.insert(0, data);
                }
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
            },
          );
        }
        return Text('');
      },
    );
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }
}
