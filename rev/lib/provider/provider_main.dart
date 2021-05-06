import 'package:flutter/cupertino.dart';

class MainProvider extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void updateState(int state) {
    _currentPage = state;
    notifyListeners();
  }
}
