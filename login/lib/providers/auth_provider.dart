import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  UserData? _currentUser;
  String? _token;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserData? get currentUser => _currentUser;
  String? get token => _token;
  bool get isAuthenticated => _token != null && _currentUser != null;

  // Método para login
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await AuthService.login(email, password);

      if (response.success && response.token != null && response.user != null) {
        _token = response.token;
        _currentUser = response.user;

        // Guardar en SharedPreferences para persistencia
        await _saveAuthData();

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e is AuthException ? e.message : 'Error desconocido';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Método para logout
  Future<void> logout() async {
    _token = null;
    _currentUser = null;
    _errorMessage = null;

    // Limpiar SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_data');

    notifyListeners();
  }

  // Método para verificar autenticación al iniciar la app
  Future<void> checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final userDataJson = prefs.getString('user_data');

    if (token != null && userDataJson != null) {
      try {
        // Verificar si el token sigue siendo válido (opcional)
        final isValid = await AuthService.verifyToken(token);

        if (isValid) {
          // Parsear los datos del usuario desde JSON
          final userData = jsonDecode(userDataJson);
          _token = token;
          _currentUser = UserData.fromJson(userData);
        } else {
          // Token inválido, limpiar datos
          await logout();
        }
      } catch (e) {
        // Error al verificar token, limpiar datos
        await logout();
      }
    }

    notifyListeners();
  }

  // Limpiar mensaje de error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Guardar datos de autenticación en SharedPreferences
  Future<void> _saveAuthData() async {
    final prefs = await SharedPreferences.getInstance();

    if (_token != null) {
      await prefs.setString('auth_token', _token!);
    }

    if (_currentUser != null) {
      final userData = {
        'id': _currentUser!.id,
        'name': _currentUser!.name,
        'email': _currentUser!.email,
        'phone': _currentUser!.phone,
        'avatar': _currentUser!.avatar,
        'created_at': _currentUser!.createdAt?.toIso8601String(),
      };
      await prefs.setString('user_data', jsonEncode(userData));
    }
  }
}
