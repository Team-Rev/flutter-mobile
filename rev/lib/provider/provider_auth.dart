import 'package:flutter/cupertino.dart';
import 'package:rev/pages/auth/auth_login.dart';

class AuthProvider extends ChangeNotifier {
  String _currentPage = AuthLogin().pageName;

  String get currentPage => _currentPage;

  void updateStatePage(String state) {
    _currentPage = state;
    notifyListeners();
  }

  void goToMain() {
    _currentPage = '1';
    notifyListeners();
  }
}
