import 'package:flutter/foundation.dart';

/// Configuración centralizada de la aplicación
/// Maneja diferentes entornos (development, production)
class AppConfig {
  // ============================================
  // CONFIGURACIÓN DE ENTORNO
  // ============================================

  /// Indica si estamos en modo debug
  static bool get isDebug => kDebugMode;

  /// Indica si estamos en web
  static bool get isWeb => kIsWeb;

  /// Indica si estamos en móvil
  static bool get isMobile => !kIsWeb;

  // ============================================
  // CONFIGURACIÓN DE RED
  // ============================================

  /// IP de tu PC en la red local
  /// IMPORTANTE: Cambia esto a tu IP local
  /// Para encontrarla:
  /// - Windows: ipconfig
  /// - Mac/Linux: ifconfig | grep "inet "
  /// - O usa: 10.0.2.2 para emulador Android
  static const String _localIP = '10.31.103.28'; // ✅ Tu IP actual
  static const String _localPort = '3000';

  /// URLs base según el entorno
  static String get baseUrl {
    if (isWeb) {
      // Para web, usa proxy o la URL completa con CORS habilitado
      return '/api'; // Proxy configurado
      // return 'http://$_localIP:$_localPort/api'; // URL directa (requiere CORS)
    } else {
      // Para móvil (Android/iOS)
      // 10.0.2.2 = localhost del emulador Android
      // 192.168.x.x = IP local de tu PC para dispositivo físico
      if (isDebug) {
        // Usa esto si estás con dispositivo físico conectado a la misma WiFi
        return 'http://$_localIP:$_localPort/api';

        // Descomenta esto si usas emulador Android:
        // return 'http://10.0.2.2:$_localPort/api';
      } else {
        // Producción: usa tu dominio real con HTTPS
        return 'https://tu-dominio.com/api';
      }
    }
  }

  // ============================================
  // ENDPOINTS DE AUTENTICACIÓN
  // ============================================

  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String verifyTokenEndpoint = '/auth/verify';
  static const String logoutEndpoint = '/auth/logout';

  // ============================================
  // ENDPOINTS DE CITAS/AGENDAMIENTO
  // ============================================

  static const String appointmentsEndpoint = '/appointments';
  static const String createAppointmentEndpoint = '/appointments/create';
  static const String myAppointmentsEndpoint = '/appointments/my-appointments';
  static const String cancelAppointmentEndpoint = '/appointments/cancel';

  // ============================================
  // ENDPOINTS DE SERVICIOS
  // ============================================

  static const String servicesEndpoint = '/services';
  static const String serviceTypesEndpoint = '/services/types';

  // ============================================
  // URLs COMPLETAS (Getters)
  // ============================================

  // Autenticación
  static String get loginUrl => '$baseUrl$loginEndpoint';
  static String get registerUrl => '$baseUrl$registerEndpoint';
  static String get verifyTokenUrl => '$baseUrl$verifyTokenEndpoint';
  static String get logoutUrl => '$baseUrl$logoutEndpoint';

  // Citas
  static String get appointmentsUrl => '$baseUrl$appointmentsEndpoint';
  static String get createAppointmentUrl =>
      '$baseUrl$createAppointmentEndpoint';
  static String get myAppointmentsUrl => '$baseUrl$myAppointmentsEndpoint';
  static String get cancelAppointmentUrl =>
      '$baseUrl$cancelAppointmentEndpoint';

  // Servicios
  static String get servicesUrl => '$baseUrl$servicesEndpoint';
  static String get serviceTypesUrl => '$baseUrl$serviceTypesEndpoint';

  // ============================================
  // CONFIGURACIÓN DE TIMEOUTS
  // ============================================

  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration connectionTimeout = Duration(seconds: 10);

  // ============================================
  // HEADERS HTTP
  // ============================================

  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> authHeaders(String token) => {
        ...defaultHeaders,
        'Authorization': 'Bearer $token',
      };

  // ============================================
  // CONFIGURACIÓN DE LA APP
  // ============================================

  static const String appName = 'MEGA LAVADO S.A.S';
  static const String appVersion = '1.0.0';

  // ============================================
  // MODO TESTING
  // ============================================

  /// Habilitar modo testing para desarrollo sin backend
  static const bool enableTestingMode =
      false; // 🔥 DESHABILITADO - Usamos backend real

  /// Emails que activan el modo testing
  static const List<String> testEmails = ['test', 'admin', 'demo'];

  /// Verificar si un email es de testing
  static bool isTestEmail(String email) {
    return testEmails.any((test) => email.toLowerCase().contains(test));
  }

  // ============================================
  // LOGGING Y DEBUG
  // ============================================

  /// Imprimir información de configuración
  static void printConfig() {
    if (isDebug) {
      print('═══════════════════════════════════════════════════');
      print('🔧 CONFIGURACIÓN DE LA APLICACIÓN');
      print('═══════════════════════════════════════════════════');
      print('📱 Plataforma: ${isWeb ? 'WEB' : 'MÓVIL'}');
      print('🐛 Debug: $isDebug');
      print('🌐 Base URL: $baseUrl');
      print('🔐 Login URL: $loginUrl');
      print('📅 Appointments URL: $appointmentsUrl');
      print('⏱️  Timeout: ${apiTimeout.inSeconds}s');
      print('🧪 Testing Mode: $enableTestingMode');
      print('═══════════════════════════════════════════════════');
    }
  }
}
