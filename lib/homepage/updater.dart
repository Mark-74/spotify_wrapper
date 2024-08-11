import 'package:flutter/widgets.dart';

class Updater with ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}

class PlayerNotifier with ChangeNotifier {
  List<String> previousSongs = List.empty(growable: true);
  int index = -1;
  String? currentSongId;
  String? currentArtistName;

  String? getPreviousSong(){
    if(index > 0) {
      index--;
      return previousSongs[index];
    }
    return null;
  }

  String? getnextSong(){
    if(index < previousSongs.length - 1) {
      index++;
      return previousSongs[index];
    }
    return null;
  }

  void updatePreviousSongs(String songId, String artistName) {
    if(index != -1 && previousSongs[index] == '$songId,$artistName') return;
    if(index != previousSongs.length - 1) {
      previousSongs.removeRange(index + 1, previousSongs.length);
    }
    previousSongs.add('$songId,$artistName');
    index++;
  }

  void notify(String songId, String artistName) {
    updatePreviousSongs(songId, artistName);
    currentSongId = songId;
    currentArtistName = artistName;
    notifyListeners();
  }
}