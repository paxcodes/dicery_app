import 'package:flutter/cupertino.dart';

class PlayerData extends ChangeNotifier {
  final List<String> _players = [];

  List<String> get players => _players;

  void addPlayer(String newPlayer) {
    _players.add(newPlayer);
    notifyListeners();
  }

  void addPlayers(List<String> newPlayers) {
    _players.addAll(newPlayers);
    notifyListeners();
  }
}
