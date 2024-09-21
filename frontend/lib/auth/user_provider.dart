import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  String _username = '';

  String get username => _username;

  void setUser(String username) {
    _username = username;
    notifyListeners();
  }
}