import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

/// Servicio para manejar todas las operaciones relacionadas con citas
class AppointmentService {
  // ============================================
  // CREAR CITA
  // ============================================

  /// Crea una nueva cita de lavado
  static Future<AppointmentResponse> createAppointment({
    required String token,
    required AppointmentData appointmentData,
  }) async {
    try {
      final url = Uri.parse(AppConfig.createAppointmentUrl);

      // MODO TESTING: Simular creación de cita sin API
      if (AppConfig.enableTestingMode &&
          AppConfig.isTestEmail(appointmentData.customerEmail ?? '')) {
        await Future.delayed(const Duration(seconds: 1)); // Simular red

        return AppointmentResponse(
          success: true,
          message: 'Cita agendada exitosamente (modo testing)',
          appointment: Appointment(
            id: DateTime.now().millisecondsSinceEpoch,
            userId: 1,
            serviceType: appointmentData.serviceType,
            vehicleType: appointmentData.vehicleType,
            date: appointmentData.date,
            time: appointmentData.time,
            address: appointmentData.address,
            customerName: appointmentData.customerName,
            customerPhone: appointmentData.customerPhone,
            customerEmail: appointmentData.customerEmail,
            status: 'pending',
            createdAt: DateTime.now(),
          ),
        );
      }

      // Llamada real al API
      final response = await http
          .post(
            url,
            headers: AppConfig.authHeaders(token),
            body: jsonEncode(appointmentData.toJson()),
          )
          .timeout(AppConfig.apiTimeout);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return AppointmentResponse.fromJson(data);
      } else if (response.statusCode == 401) {
        throw AppointmentException(
            'Sesión expirada. Inicia sesión nuevamente.');
      } else if (response.statusCode == 422) {
        final data = jsonDecode(response.body);
        throw AppointmentException(data['message'] ?? 'Datos inválidos');
      } else {
        throw AppointmentException(
            'Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      if (e is AppointmentException) {
        rethrow;
      }
      throw AppointmentException(
          'Error de conexión. Verifica tu conexión a internet.');
    }
  }

  // ============================================
  // OBTENER MIS CITAS
  // ============================================

  /// Obtiene todas las citas del usuario actual
  static Future<List<Appointment>> getMyAppointments(String token) async {
    try {
      final url = Uri.parse(AppConfig.myAppointmentsUrl);

      // MODO TESTING: Retornar citas de ejemplo
      if (AppConfig.enableTestingMode) {
        await Future.delayed(const Duration(milliseconds: 500));

        return [
          Appointment(
            id: 1,
            userId: 1,
            serviceType: 'Lavado Completo',
            vehicleType: 'Automóvil',
            date: '2025-10-05',
            time: '14:00',
            address: 'Calle 123 #45-67',
            customerName: 'Usuario Test',
            customerPhone: '+573001234567',
            customerEmail: 'test@example.com',
            status: 'pending',
            createdAt: DateTime.now().subtract(const Duration(days: 1)),
          ),
          Appointment(
            id: 2,
            userId: 1,
            serviceType: 'Lavado Exterior',
            vehicleType: 'Camioneta',
            date: '2025-10-08',
            time: '10:00',
            address: 'Carrera 45 #12-34',
            customerName: 'Usuario Test',
            customerPhone: '+573001234567',
            customerEmail: 'test@example.com',
            status: 'confirmed',
            createdAt: DateTime.now().subtract(const Duration(days: 3)),
          ),
        ];
      }

      final response = await http
          .get(
            url,
            headers: AppConfig.authHeaders(token),
          )
          .timeout(AppConfig.apiTimeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Appointment.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        throw AppointmentException('Sesión expirada');
      } else {
        throw AppointmentException('Error al cargar citas');
      }
    } catch (e) {
      if (e is AppointmentException) {
        rethrow;
      }
      throw AppointmentException('Error de conexión');
    }
  }

  // ============================================
  // CANCELAR CITA
  // ============================================

  /// Cancela una cita existente
  static Future<bool> cancelAppointment({
    required String token,
    required int appointmentId,
  }) async {
    try {
      final url = Uri.parse('${AppConfig.cancelAppointmentUrl}/$appointmentId');

      // MODO TESTING
      if (AppConfig.enableTestingMode) {
        await Future.delayed(const Duration(milliseconds: 500));
        return true;
      }

      final response = await http
          .delete(
            url,
            headers: AppConfig.authHeaders(token),
          )
          .timeout(AppConfig.apiTimeout);

      return response.statusCode == 200;
    } catch (e) {
      throw AppointmentException('Error al cancelar cita');
    }
  }

  // ============================================
  // OBTENER TIPOS DE SERVICIO
  // ============================================

  /// Obtiene los tipos de servicio disponibles
  static Future<List<ServiceType>> getServiceTypes() async {
    try {
      // Por ahora retornamos datos hardcodeados
      // Luego puedes conectarlo a tu API
      return [
        ServiceType(
          id: 1,
          name: 'Lavado Completo',
          description: 'Lavado exterior e interior con vapor',
          price: 35000,
          duration: 60,
        ),
        ServiceType(
          id: 2,
          name: 'Lavado Exterior',
          description: 'Lavado exterior con vapor',
          price: 20000,
          duration: 30,
        ),
        ServiceType(
          id: 3,
          name: 'Lavado Motor',
          description: 'Limpieza profunda del motor',
          price: 25000,
          duration: 45,
        ),
        ServiceType(
          id: 4,
          name: 'Lavado Premium',
          description: 'Lavado completo + encerado + detallado',
          price: 50000,
          duration: 90,
        ),
      ];
    } catch (e) {
      throw AppointmentException('Error al cargar servicios');
    }
  }
}

// ============================================
// MODELOS DE DATOS
// ============================================

/// Modelo para crear una cita
class AppointmentData {
  final String serviceType;
  final String vehicleType;
  final String date;
  final String time;
  final String address;
  final String? customerName;
  final String? customerPhone;
  final String? customerEmail;
  final String? notes;

  AppointmentData({
    required this.serviceType,
    required this.vehicleType,
    required this.date,
    required this.time,
    required this.address,
    this.customerName,
    this.customerPhone,
    this.customerEmail,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
        'serviceType': serviceType,
        'vehicleType': vehicleType,
        'date': date,
        'time': time,
        'address': address,
        'customerName': customerName,
        'customerPhone': customerPhone,
        'customerEmail': customerEmail,
        'notes': notes,
      };
}

/// Modelo de respuesta al crear una cita
class AppointmentResponse {
  final bool success;
  final String message;
  final Appointment? appointment;

  AppointmentResponse({
    required this.success,
    required this.message,
    this.appointment,
  });

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      appointment: json['appointment'] != null
          ? Appointment.fromJson(json['appointment'])
          : null,
    );
  }
}

/// Modelo de una cita
class Appointment {
  final int id;
  final int userId;
  final String serviceType;
  final String vehicleType;
  final String date;
  final String time;
  final String address;
  final String? customerName;
  final String? customerPhone;
  final String? customerEmail;
  final String? notes;
  final String status; // pending, confirmed, completed, cancelled
  final DateTime createdAt;
  final DateTime? updatedAt;

  Appointment({
    required this.id,
    required this.userId,
    required this.serviceType,
    required this.vehicleType,
    required this.date,
    required this.time,
    required this.address,
    this.customerName,
    this.customerPhone,
    this.customerEmail,
    this.notes,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? json['user_id'] ?? 0,
      serviceType: json['serviceType'] ?? json['service_type'] ?? '',
      vehicleType: json['vehicleType'] ?? json['vehicle_type'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      address: json['address'] ?? '',
      customerName: json['customerName'] ?? json['customer_name'],
      customerPhone: json['customerPhone'] ?? json['customer_phone'],
      customerEmail: json['customerEmail'] ?? json['customer_email'],
      notes: json['notes'],
      status: json['status'] ?? 'pending',
      createdAt: json['createdAt'] != null || json['created_at'] != null
          ? DateTime.parse(json['createdAt'] ?? json['created_at'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null || json['updated_at'] != null
          ? DateTime.parse(json['updatedAt'] ?? json['updated_at'])
          : null,
    );
  }

  /// Obtener color según el estado
  String get statusColor {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return '#4CAF50'; // Verde
      case 'pending':
        return '#FF9800'; // Naranja
      case 'completed':
        return '#2196F3'; // Azul
      case 'cancelled':
        return '#F44336'; // Rojo
      default:
        return '#9E9E9E'; // Gris
    }
  }

  /// Obtener texto legible del estado
  String get statusText {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return 'Confirmada';
      case 'pending':
        return 'Pendiente';
      case 'completed':
        return 'Completada';
      case 'cancelled':
        return 'Cancelada';
      default:
        return status;
    }
  }
}

/// Modelo de tipo de servicio
class ServiceType {
  final int id;
  final String name;
  final String description;
  final double price;
  final int duration; // minutos

  ServiceType({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) {
    return ServiceType(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      duration: json['duration'] ?? 0,
    );
  }
}

/// Excepción personalizada para errores de citas
class AppointmentException implements Exception {
  final String message;

  AppointmentException(this.message);

  @override
  String toString() => message;
}
