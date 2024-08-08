import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _username;
  bool _isDarkMode;

  UserProvider(this._username) : _isDarkMode = true;

  String get username => _username;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme(String theme) {
    if (theme == "Dark") {
      _isDarkMode = true;
    } else {
      _isDarkMode = false;
    }
    notifyListeners();
  }

  void logOut() {
    _username = "";
    notifyListeners();
  }

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }
}
