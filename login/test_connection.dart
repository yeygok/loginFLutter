import 'dart:convert';
import 'package:http/http.dart' as http;

/// Script de prueba rápida para verificar conectividad con el backend
///
/// Ejecutar con: dart test_connection.dart
void main() async {
  print('═══════════════════════════════════════════════════');
  print('🔌 PRUEBA DE CONECTIVIDAD CON EL BACKEND');
  print('═══════════════════════════════════════════════════\n');

  const String baseUrl = 'http://10.31.103.28:3000';
  const String apiUrl = '$baseUrl/api';

  // ============================================
  // PRUEBA 1: Health Check
  // ============================================
  print('📡 PRUEBA 1: Health Check');
  print('   URL: $baseUrl/health\n');

  try {
    final healthResponse = await http
        .get(Uri.parse('$baseUrl/health'))
        .timeout(const Duration(seconds: 5));

    if (healthResponse.statusCode == 200) {
      print('   ✅ Servidor respondiendo correctamente');
      print('   📄 Respuesta: ${healthResponse.body}\n');
    } else {
      print('   ❌ Error: ${healthResponse.statusCode}');
      print('   📄 ${healthResponse.body}\n');
    }
  } catch (e) {
    print('   ❌ Error de conexión: $e\n');
    print('\n⚠️  SOLUCIONES POSIBLES:');
    print('   1. Verifica que el servidor esté corriendo: npm start');
    print('   2. Verifica que tu IP sea correcta: ifconfig | grep "inet "');
    print('   3. Verifica que el firewall permita conexiones al puerto 3000\n');
    return;
  }

  // ============================================
  // PRUEBA 2: Login
  // ============================================
  print('🔐 PRUEBA 2: Login API');
  print('   URL: $apiUrl/auth/login');
  print('   Email: yeygok777@gmail.com');
  print('   Password: 121212\n');

  try {
    final loginResponse = await http
        .post(
          Uri.parse('$apiUrl/auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': 'yeygok777@gmail.com',
            'password': '121212',
          }),
        )
        .timeout(const Duration(seconds: 10));

    if (loginResponse.statusCode == 200) {
      final data = jsonDecode(loginResponse.body);
      print('   ✅ Login exitoso!');
      print(
          '   👤 Usuario: ${data['user']['nombre']} ${data['user']['apellido']}');
      print('   📧 Email: ${data['user']['email']}');
      print('   🔑 Token: ${data['token'].substring(0, 30)}...');
      print('   🎭 Rol: ${data['user']['rol']['nombre']}\n');
    } else {
      print('   ❌ Error de login: ${loginResponse.statusCode}');
      print('   📄 ${loginResponse.body}\n');
    }
  } catch (e) {
    print('   ❌ Error al hacer login: $e\n');
  }

  print('═══════════════════════════════════════════════════');
  print('✅ PRUEBA COMPLETADA');
  print('═══════════════════════════════════════════════════\n');

  print('📱 SIGUIENTE PASO: Ejecutar la app Flutter');
  print('   flutter run');
  print('   O desde VS Code: F5\n');
}
