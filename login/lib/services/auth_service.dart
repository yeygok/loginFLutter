import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

class AuthService {
  // Método para login
  static Future<LoginResponse> login(String email, String password) async {
    try {
      final url = Uri.parse(AppConfig.loginUrl);

      print('🔐 Intentando login a: $url');
      print('📧 Email: $email');

      final response = await http
          .post(
            url,
            headers: AppConfig.defaultHeaders,
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(AppConfig.apiTimeout);

      print('📥 Respuesta del servidor: ${response.statusCode}');
      print('📄 Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return LoginResponse.fromJson(data);
      } else if (response.statusCode == 401) {
        throw AuthException('Credenciales incorrectas');
      } else if (response.statusCode == 422) {
        final data = jsonDecode(response.body);
        throw AuthException(data['message'] ?? 'Datos inválidos');
      } else {
        throw AuthException('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error en login: $e');
      if (e is AuthException) {
        rethrow;
      }
      throw AuthException(
          'Error de conexión. Verifica tu conexión a internet.');
    }
  }

  // Método para verificar si el token es válido
  static Future<bool> verifyToken(String token) async {
    try {
      final url = Uri.parse(AppConfig.verifyTokenUrl);

      final response = await http.get(
        url,
        headers: {
          ...AppConfig.defaultHeaders,
          'Authorization': 'Bearer $token',
        },
      ).timeout(AppConfig.apiTimeout);

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

// Modelo de respuesta de login
class LoginResponse {
  final bool success;
  final String message;
  final UserData? user;
  final String? token;

  LoginResponse({
    required this.success,
    required this.message,
    this.user,
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      user: json['user'] != null ? UserData.fromJson(json['user']) : null,
      token: json['token'],
    );
  }
}

// Modelo de datos del usuario
class UserData {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  final DateTime? createdAt;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
    this.createdAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      avatar: json['avatar'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}

// Excepción personalizada para errores de autenticación
class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() => message;
}
