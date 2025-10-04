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

  /// MODOS DE CONEXIÓN:
  /// - 'local': Misma red WiFi (192.168.x.x o 10.x.x.x)
  /// - 'ngrok': Túnel público con ngrok (funciona desde cualquier red)
  /// - 'production': Servidor en producción con dominio real
  static const String _connectionMode = 'ngrok'; // 👈 Cambiado a ngrok

  /// IP de tu PC en la red local (solo para modo 'local')
  static const String _localIP = '10.31.103.28';
  static const String _localPort = '3000';

  /// URL de ngrok (solo para modo 'ngrok')
  /// Ejemplo: 'https://abc123.ngrok.io'
  /// Obtén esta URL ejecutando: ngrok http 3000
  static const String _ngrokUrl =
      'https://bardlike-reita-anthropomorphically.ngrok-free.dev';

  /// URL de producción (solo para modo 'production')
  static const String _productionUrl = 'https://tu-dominio.com';

  /// URLs base según el entorno y modo de conexión
  static String get baseUrl {
    // En modo debug, usar la configuración según _connectionMode
    if (isDebug) {
      switch (_connectionMode) {
        case 'local':
          // Mismo WiFi - usar IP local
          if (isWeb) {
            return 'http://$_localIP:$_localPort/api';
          } else {
            // Android/iOS
            return 'http://$_localIP:$_localPort/api';
          }

        case 'ngrok':
          // Túnel público - funciona desde cualquier red
          return '$_ngrokUrl/api';

        case 'production':
          // Servidor en producción
          return '$_productionUrl/api';

        default:
          throw Exception('Modo de conexión no válido: $_connectionMode');
      }
    } else {
      // En producción siempre usar la URL de producción
      return '$_productionUrl/api';
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
      print('🔌 Modo de Conexión: $_connectionMode');
      print('🌐 Base URL: $baseUrl');
      print('🔐 Login URL: $loginUrl');
      print('📅 Appointments URL: $appointmentsUrl');
      print('⏱️  Timeout: ${apiTimeout.inSeconds}s');
      print('🧪 Testing Mode: $enableTestingMode');
      if (_connectionMode == 'local') {
        print('💡 Consejo: Para conectar desde otra red, usa ngrok');
        print('   Ver: CONECTAR_REDES_DIFERENTES.md');
      }
      print('═══════════════════════════════════════════════════');
    }
  }
}
