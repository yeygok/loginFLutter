import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

/// Servicio para manejar las reservas/citas con el backend
class ReservationService {
  // ============================================
  // CREAR RESERVA
  // ============================================

  /// Crea una nueva reserva en el backend
  ///
  /// Estructura del JSON que espera tu backend:
  /// ```json
  /// {
  ///   "cliente_id": 3,
  ///   "servicio_tipo_id": 1,
  ///   "ubicacion_servicio_id": 1,
  ///   "fecha_servicio": "2025-09-28T15:30:00",
  ///   "precio_total": 45000,
  ///   "estado_id": 2,
  ///   "tecnico_id": 1,
  ///   "vehiculo_id": 2,
  ///   "observaciones": "...",
  ///   "notas_tecnico": ""
  /// }
  /// ```
  static Future<ReservationResponse> createReservation({
    required int clienteId,
    required int servicioTipoId,
    required int ubicacionServicioId,
    required String fechaServicio,
    required int precioTotal,
    required int estadoId,
    required int tecnicoId,
    required int vehiculoId,
    required String observaciones,
    String? notasTecnico,
  }) async {
    try {
      // URL del endpoint de crear reserva
      final url = Uri.parse('${AppConfig.baseUrl}/reservas');

      // Construir el body según la estructura de tu backend
      final body = {
        "cliente_id": clienteId,
        "servicio_tipo_id": servicioTipoId,
        "ubicacion_servicio_id": ubicacionServicioId,
        "fecha_servicio": fechaServicio,
        "precio_total": precioTotal,
        "estado_id": estadoId,
        "tecnico_id": tecnicoId,
        "vehiculo_id": vehiculoId,
        "observaciones": observaciones,
        "notas_tecnico": notasTecnico ?? "",
      };

      print('🚀 Enviando reserva a: $url');
      print('📦 Body: ${jsonEncode(body)}');

      final response = await http
          .post(
            url,
            headers: AppConfig.defaultHeaders,
            body: jsonEncode(body),
          )
          .timeout(AppConfig.apiTimeout);

      print('📥 Respuesta del servidor: ${response.statusCode}');
      print('📄 Body de respuesta: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return ReservationResponse(
          success: true,
          message: data['message'] ?? 'Reserva creada exitosamente',
          reservationId: data['reserva_id'] ?? data['id'],
        );
      } else if (response.statusCode == 422) {
        final data = jsonDecode(response.body);
        throw ReservationException(data['message'] ?? 'Datos inválidos');
      } else {
        throw ReservationException(
            'Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error al crear reserva: $e');
      if (e is ReservationException) {
        rethrow;
      }
      throw ReservationException(
          'Error de conexión. Verifica tu conexión a internet y que el servidor esté corriendo.');
    }
  }

  // ============================================
  // OBTENER MIS RESERVAS
  // ============================================

  /// Obtiene todas las reservas del cliente
  static Future<List<Reservation>> getMyReservations(int clienteId) async {
    try {
      final url = Uri.parse('${AppConfig.baseUrl}/reservas/cliente/$clienteId');

      print('🔍 Obteniendo reservas de: $url');

      final response = await http
          .get(
            url,
            headers: AppConfig.defaultHeaders,
          )
          .timeout(AppConfig.apiTimeout);

      print('📥 Respuesta: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Reservation.fromJson(json)).toList();
      } else {
        throw ReservationException('Error al cargar reservas');
      }
    } catch (e) {
      print('❌ Error al obtener reservas: $e');
      if (e is ReservationException) {
        rethrow;
      }
      throw ReservationException('Error de conexión');
    }
  }

  // ============================================
  // CANCELAR RESERVA
  // ============================================

  /// Cancela una reserva existente
  static Future<bool> cancelReservation(int reservaId) async {
    try {
      final url =
          Uri.parse('${AppConfig.baseUrl}/reservas/$reservaId/cancelar');

      final response = await http
          .put(
            url,
            headers: AppConfig.defaultHeaders,
          )
          .timeout(AppConfig.apiTimeout);

      return response.statusCode == 200;
    } catch (e) {
      print('❌ Error al cancelar reserva: $e');
      throw ReservationException('Error al cancelar reserva');
    }
  }
}

// ============================================
// MODELOS DE DATOS
// ============================================

/// Modelo de respuesta al crear una reserva
class ReservationResponse {
  final bool success;
  final String message;
  final int? reservationId;

  ReservationResponse({
    required this.success,
    required this.message,
    this.reservationId,
  });
}

/// Modelo de una reserva
class Reservation {
  final int id;
  final int clienteId;
  final int servicioTipoId;
  final int ubicacionServicioId;
  final String fechaServicio;
  final int precioTotal;
  final int estadoId;
  final int tecnicoId;
  final int vehiculoId;
  final String observaciones;
  final String? notasTecnico;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Datos adicionales que pueda retornar tu API
  final String? servicioNombre;
  final String? estadoNombre;
  final String? tecnicoNombre;
  final String? tecnicoTelefono;
  final String? vehiculoPlaca;
  final String? vehiculoMarca;

  Reservation({
    required this.id,
    required this.clienteId,
    required this.servicioTipoId,
    required this.ubicacionServicioId,
    required this.fechaServicio,
    required this.precioTotal,
    required this.estadoId,
    required this.tecnicoId,
    required this.vehiculoId,
    required this.observaciones,
    this.notasTecnico,
    this.createdAt,
    this.updatedAt,
    this.servicioNombre,
    this.estadoNombre,
    this.tecnicoNombre,
    this.tecnicoTelefono,
    this.vehiculoPlaca,
    this.vehiculoMarca,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'] ?? json['reserva_id'] ?? 0,
      clienteId: json['cliente_id'] ?? 0,
      servicioTipoId: json['servicio_tipo_id'] ?? 0,
      ubicacionServicioId: json['ubicacion_servicio_id'] ?? 0,
      fechaServicio: json['fecha_servicio'] ?? '',
      precioTotal: json['precio_total'] ?? 0,
      estadoId: json['estado_id'] ?? 0,
      tecnicoId: json['tecnico_id'] ?? 0,
      vehiculoId: json['vehiculo_id'] ?? 0,
      observaciones: json['observaciones'] ?? '',
      notasTecnico: json['notas_tecnico'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      servicioNombre: json['servicio_nombre'],
      estadoNombre: json['estado_nombre'],
      tecnicoNombre: json['tecnico_nombre'],
      tecnicoTelefono: json['tecnico_telefono'],
      vehiculoPlaca: json['vehiculo_placa'],
      vehiculoMarca: json['vehiculo_marca'],
    );
  }

  /// Obtener estado en español
  String get estadoTexto {
    switch (estadoId) {
      case 1:
        return 'Solicitado';
      case 2:
        return 'Programado';
      case 3:
        return 'En Proceso';
      case 4:
        return 'Completado';
      case 5:
        return 'Cancelado';
      default:
        return estadoNombre ?? 'Desconocido';
    }
  }

  /// Obtener color según el estado
  String get estadoColor {
    switch (estadoId) {
      case 1:
        return '#FF9800'; // Naranja - Solicitado
      case 2:
        return '#2196F3'; // Azul - Programado
      case 3:
        return '#9C27B0'; // Púrpura - En Proceso
      case 4:
        return '#4CAF50'; // Verde - Completado
      case 5:
        return '#F44336'; // Rojo - Cancelado
      default:
        return '#9E9E9E'; // Gris
    }
  }
}

/// Excepción personalizada para errores de reservas
class ReservationException implements Exception {
  final String message;

  ReservationException(this.message);

  @override
  String toString() => message;
}
