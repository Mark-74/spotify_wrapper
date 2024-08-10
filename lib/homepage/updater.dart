import 'package:flutter/widgets.dart';

class Updater with ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}