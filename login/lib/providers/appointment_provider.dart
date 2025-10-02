import 'package:flutter/material.dart';
import '../services/appointment_service.dart';

/// Provider para manejar el estado de las citas
class AppointmentProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<Appointment> _appointments = [];
  List<ServiceType> _serviceTypes = [];

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Appointment> get appointments => _appointments;
  List<ServiceType> get serviceTypes => _serviceTypes;

  // ============================================
  // CREAR CITA
  // ============================================

  Future<bool> createAppointment({
    required String token,
    required AppointmentData appointmentData,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await AppointmentService.createAppointment(
        token: token,
        appointmentData: appointmentData,
      );

      if (response.success) {
        // Agregar la nueva cita a la lista
        if (response.appointment != null) {
          _appointments.insert(0, response.appointment!);
        }

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
      _errorMessage =
          e is AppointmentException ? e.message : 'Error al crear la cita';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ============================================
  // OBTENER MIS CITAS
  // ============================================

  Future<void> loadMyAppointments(String token) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _appointments = await AppointmentService.getMyAppointments(token);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage =
          e is AppointmentException ? e.message : 'Error al cargar las citas';
      _isLoading = false;
      notifyListeners();
    }
  }

  // ============================================
  // CANCELAR CITA
  // ============================================

  Future<bool> cancelAppointment({
    required String token,
    required int appointmentId,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await AppointmentService.cancelAppointment(
        token: token,
        appointmentId: appointmentId,
      );

      if (success) {
        // Actualizar el estado de la cita localmente
        final index =
            _appointments.indexWhere((apt) => apt.id == appointmentId);
        if (index != -1) {
          _appointments.removeAt(index);
        }
      }

      _isLoading = false;
      notifyListeners();
      return success;
    } catch (e) {
      _errorMessage =
          e is AppointmentException ? e.message : 'Error al cancelar la cita';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ============================================
  // CARGAR TIPOS DE SERVICIO
  // ============================================

  Future<void> loadServiceTypes() async {
    if (_serviceTypes.isNotEmpty) return; // Ya cargados

    try {
      _serviceTypes = await AppointmentService.getServiceTypes();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error al cargar servicios';
      notifyListeners();
    }
  }

  // ============================================
  // UTILIDADES
  // ============================================

  /// Limpiar mensaje de error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Obtener citas por estado
  List<Appointment> getAppointmentsByStatus(String status) {
    return _appointments
        .where((apt) => apt.status.toLowerCase() == status.toLowerCase())
        .toList();
  }

  /// Obtener citas pendientes
  List<Appointment> get pendingAppointments =>
      getAppointmentsByStatus('pending');

  /// Obtener citas confirmadas
  List<Appointment> get confirmedAppointments =>
      getAppointmentsByStatus('confirmed');

  /// Obtener citas completadas
  List<Appointment> get completedAppointments =>
      getAppointmentsByStatus('completed');
}
