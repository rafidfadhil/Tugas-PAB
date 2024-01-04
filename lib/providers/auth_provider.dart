import 'package:flutter/material.dart';
import 'package:uts_pengembangan_aplikasi/models/user_model.dart';
import 'package:uts_pengembangan_aplikasi/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _user;

  UserModel? get user => _user;

  Future<bool> login({String? email, String? password}) async {
    try {
      _user = await _authService.login(email: email, password: password);
      // Jika _user tidak null maka notify listeners
      if (_user != null) {
        notifyListeners();
      }
      return _user != null;
    } catch (e) {
      // Anda bisa mengganti ini dengan logging framework yang lebih baik
      debugPrint('Login Error: $e');
      return false;
    }
  }

  Future<bool> register({String? name, String? email, String? password}) async {
    try {
      _user = await _authService.register(name: name, email: email, password: password);
      // Jika _user tidak null maka notify listeners
      if (_user != null) {
        notifyListeners();
      }
      return _user != null;
    } catch (e) {
      // Anda bisa mengganti ini dengan logging framework yang lebih baik
      debugPrint('Register Error: $e');
      return false;
    }
  }


  // Fungsi untuk logout (opsional)
  void logout() {
    _user = null;
    notifyListeners();
  }
}