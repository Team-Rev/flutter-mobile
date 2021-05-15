import 'package:flutter/cupertino.dart';

class CurrentPageListProvider extends ChangeNotifier {
  int _currentPageList = 0;

  int get currentPageList => _currentPageList;

  void updateState(int state) {
    _currentPageList = state;
    notifyListeners();
  }
}
