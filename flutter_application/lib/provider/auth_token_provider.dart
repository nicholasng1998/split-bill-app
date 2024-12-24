import 'package:flutter/material.dart';

class AuthTokenProvider with ChangeNotifier {
  String? _authToken;

  String? get authToken => _authToken;

  void login(String authToken) {
    _authToken = authToken;
    notifyListeners();
  }
}
