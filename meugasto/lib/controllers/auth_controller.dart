import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthController extends ChangeNotifier {
  final _service = AuthService();

  AuthController() {
    _service.authStateChanges.listen((_) {
      notifyListeners();
    });
  }

  get user => _service.currentUser;

  Future<void> login(String email, String password) async {
    await _service.login(email, password);
  }

  Future<void> register(String email, String password) async {
    await _service.register(email, password);
  }

  Future<void> logout() async {
    await _service.logout();
  }
}
