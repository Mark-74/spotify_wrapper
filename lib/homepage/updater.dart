import 'package:flutter/widgets.dart';

class Updater with ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}

class PlayerNotifier with ChangeNotifier {
  String? currentSongId;
  String? currentArtistName;

  void notify(String songId, String artistName) {
    currentSongId = songId;
    currentArtistName = artistName;
    notifyListeners();
  }
}