import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/auth_provider.dart';
import '../providers/appointment_provider.dart';
import '../services/appointment_service.dart';

/// Pantalla principal para agendar una nueva cita
class CreateAppointmentScreen extends StatefulWidget {
  const CreateAppointmentScreen({super.key});

  @override
  State<CreateAppointmentScreen> createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();

  // Datos del formulario
  ServiceType? _selectedService;
  String? _selectedVehicleType;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  // Opciones de tipos de vehículo
  final List<String> _vehicleTypes = [
    'Automóvil',
    'Camioneta',
    'SUV',
    'Moto',
    'Otro',
  ];

  @override
  void initState() {
    super.initState();
    // Cargar tipos de servicio
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppointmentProvider>(context, listen: false)
          .loadServiceTypes();
    });
  }

  @override
  void dispose() {
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  // Seleccionar fecha
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4285F4),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Seleccionar hora
  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4285F4),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // Agendar cita
  Future<void> _submitAppointment() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedService == null) {
      _showSnackBar('Por favor selecciona un tipo de servicio', isError: true);
      return;
    }

    if (_selectedVehicleType == null) {
      _showSnackBar('Por favor selecciona el tipo de vehículo', isError: true);
      return;
    }

    if (_selectedDate == null) {
      _showSnackBar('Por favor selecciona una fecha', isError: true);
      return;
    }

    if (_selectedTime == null) {
      _showSnackBar('Por favor selecciona una hora', isError: true);
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final appointmentProvider =
        Provider.of<AppointmentProvider>(context, listen: false);

    if (authProvider.token == null) {
      _showSnackBar('Sesión expirada. Inicia sesión nuevamente', isError: true);
      return;
    }

    final appointmentData = AppointmentData(
      serviceType: _selectedService!.name,
      vehicleType: _selectedVehicleType!,
      date: DateFormat('yyyy-MM-dd').format(_selectedDate!),
      time: _selectedTime!.format(context),
      address: _addressController.text,
      customerName: authProvider.currentUser?.name,
      customerPhone: authProvider.currentUser?.phone,
      customerEmail: authProvider.currentUser?.email,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
    );

    final success = await appointmentProvider.createAppointment(
      token: authProvider.token!,
      appointmentData: appointmentData,
    );

    if (success && mounted) {
      _showSnackBar('¡Cita agendada exitosamente!', isError: false);
      Navigator.pop(context, true); // Volver con resultado exitoso
    } else if (mounted) {
      _showSnackBar(
        appointmentProvider.errorMessage ?? 'Error al agendar la cita',
        isError: true,
      );
    }
  }

  void _showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar Cita'),
        backgroundColor: const Color(0xFF4285F4),
        elevation: 0,
      ),
      body: Consumer<AppointmentProvider>(
        builder: (context, appointmentProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  _buildHeader(),
                  const SizedBox(height: 24),

                  // Selección de servicio
                  _buildSectionTitle('1. Tipo de Servicio'),
                  const SizedBox(height: 12),
                  _buildServiceSelector(appointmentProvider.serviceTypes),
                  const SizedBox(height: 24),

                  // Tipo de vehículo
                  _buildSectionTitle('2. Tipo de Vehículo'),
                  const SizedBox(height: 12),
                  _buildVehicleSelector(),
                  const SizedBox(height: 24),

                  // Fecha y hora
                  _buildSectionTitle('3. Fecha y Hora'),
                  const SizedBox(height: 12),
                  _buildDateTimeSelector(),
                  const SizedBox(height: 24),

                  // Dirección
                  _buildSectionTitle('4. Dirección'),
                  const SizedBox(height: 12),
                  _buildAddressField(),
                  const SizedBox(height: 24),

                  // Notas adicionales
                  _buildSectionTitle('5. Notas Adicionales (Opcional)'),
                  const SizedBox(height: 12),
                  _buildNotesField(),
                  const SizedBox(height: 32),

                  // Botón de agendar
                  _buildSubmitButton(appointmentProvider.isLoading),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4285F4), Color(0xFF34A853)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(Icons.local_car_wash, color: Colors.white, size: 40),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MEGA LAVADO S.A.S',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Lavado a vapor profesional a domicilio',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildServiceSelector(List<ServiceType> services) {
    if (services.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: services.map((service) {
        final isSelected = _selectedService?.id == service.id;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedService = service;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF4285F4).withOpacity(0.1)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? const Color(0xFF4285F4) : Colors.grey[300]!,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  color: isSelected ? const Color(0xFF4285F4) : Colors.grey,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? const Color(0xFF4285F4)
                              : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service.description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '\$${NumberFormat('#,###').format(service.price)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF34A853),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(Icons.access_time,
                              size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            '${service.duration} min',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildVehicleSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _vehicleTypes.map((type) {
        final isSelected = _selectedVehicleType == type;
        return ChoiceChip(
          label: Text(type),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedVehicleType = selected ? type : null;
            });
          },
          selectedColor: const Color(0xFF4285F4),
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDateTimeSelector() {
    return Row(
      children: [
        Expanded(
          child: _buildDateButton(),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildTimeButton(),
        ),
      ],
    );
  }

  Widget _buildDateButton() {
    return OutlinedButton.icon(
      onPressed: _selectDate,
      icon: const Icon(Icons.calendar_today),
      label: Text(
        _selectedDate != null
            ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
            : 'Seleccionar fecha',
        style: TextStyle(
          color: _selectedDate != null ? Colors.black87 : Colors.grey,
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: BorderSide(
          color: _selectedDate != null
              ? const Color(0xFF4285F4)
              : Colors.grey[300]!,
        ),
      ),
    );
  }

  Widget _buildTimeButton() {
    return OutlinedButton.icon(
      onPressed: _selectTime,
      icon: const Icon(Icons.access_time),
      label: Text(
        _selectedTime != null
            ? _selectedTime!.format(context)
            : 'Seleccionar hora',
        style: TextStyle(
          color: _selectedTime != null ? Colors.black87 : Colors.grey,
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: BorderSide(
          color: _selectedTime != null
              ? const Color(0xFF4285F4)
              : Colors.grey[300]!,
        ),
      ),
    );
  }

  Widget _buildAddressField() {
    return TextFormField(
      controller: _addressController,
      decoration: InputDecoration(
        hintText: 'Ej: Calle 123 #45-67, Apartamento 301',
        prefixIcon: const Icon(Icons.location_on),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4285F4), width: 2),
        ),
      ),
      maxLines: 2,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa la dirección';
        }
        if (value.length < 10) {
          return 'La dirección debe ser más específica';
        }
        return null;
      },
    );
  }

  Widget _buildNotesField() {
    return TextFormField(
      controller: _notesController,
      decoration: InputDecoration(
        hintText: 'Instrucciones adicionales, referencias, etc.',
        prefixIcon: const Icon(Icons.note),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4285F4), width: 2),
        ),
      ),
      maxLines: 3,
    );
  }

  Widget _buildSubmitButton(bool isLoading) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : _submitAppointment,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4285F4),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 24),
                  SizedBox(width: 12),
                  Text(
                    'Agendar Cita',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
