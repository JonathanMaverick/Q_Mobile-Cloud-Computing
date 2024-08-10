import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _username;
  int? _id;
  bool _isDarkMode;

  UserProvider(this._username, this._id) : _isDarkMode = true;

  String get username => _username;
  int get id => _id!;
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
    _id = null;
    notifyListeners();
  }

  void setUser(String username, int id) {
    _username = username;
    _id = id;
    notifyListeners();
  }
}
