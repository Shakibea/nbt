import 'package:flutter/foundation.dart';

class NewOrderProvider extends ChangeNotifier {
  int _count = 1;

  int get count => _count;

  void incrementCount() {
    if (_count == 10) {
      _count;
    } else {
      _count++;
    }
    notifyListeners();
  }

  void decrementCount() {
    if (_count == 1) {
      _count;
    } else {
      _count--;
    }
    notifyListeners();
  }
}
