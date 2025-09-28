import 'package:flutter/material.dart';

class BookingFlow extends StatefulWidget {
  final String serviceName;
  final String planName;
  final int price;
  final int serviceTypeId;

  const BookingFlow({
    super.key,
    required this.serviceName,
    required this.planName,
    required this.price,
    required this.serviceTypeId,
  });

  @override
  State<BookingFlow> createState() => _BookingFlowState();
}

class _BookingFlowState extends State<BookingFlow> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Form controllers
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _observationsController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _observationsController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _confirmBooking() {
    // Aquí construirías el JSON final con todos los datos
    final bookingData = {
      "cliente_id": 3, // Este vendría del usuario logueado
      "servicio_tipo_id": widget.serviceTypeId,
      "ubicacion_servicio_id": 1, // Se asignaría automáticamente
      "fecha_servicio": _selectedDate != null && _selectedTime != null
          ? "${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}T${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}:00"
          : null,
      "precio_total": widget.price,
      "estado_id": 2, // Estado "Programado"
      "tecnico_id": 1, // Se asigna automáticamente
      "vehiculo_id": 2, // Se asigna automáticamente
      "observaciones": _observationsController.text.isEmpty
          ? "Servicio ${widget.serviceName} - Plan ${widget.planName}"
          : _observationsController.text,
      "notas_tecnico": "",
      // Datos adicionales del cliente
      "cliente_nombre": _nameController.text,
      "cliente_apellido": _lastNameController.text,
      "cliente_telefono": _phoneController.text,
      "direccion_servicio": _addressController.text,
      "ciudad": _cityController.text,
    };

    // Aquí enviarías los datos a la API
    debugPrint("Datos de reserva: $bookingData");

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            '¡Servicio agendado exitosamente! Te contactaremos en las próximas 2 horas.'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildHeader(),
            _buildStepIndicator(),
            const SizedBox(height: 20),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentStep = index),
                children: [
                  _buildStep1PersonalData(),
                  _buildStep2Address(),
                  _buildStep3DateTime(),
                ],
              ),
            ),
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            const Expanded(
              child: Text(
                'Agendar Servicio',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 48), // Para balancear el botón de atrás
          ],
        ),
        Text(
          'Paso ${_currentStep + 1} de 3',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 3; i++) ...[
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: i <= _currentStep ? Colors.blue : Colors.grey[300],
            ),
            child: Center(
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  color: i <= _currentStep ? Colors.white : Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (i < 2) ...[
            Container(
              width: 40,
              height: 2,
              color: i < _currentStep ? Colors.blue : Colors.grey[300],
            ),
          ],
        ],
      ],
    );
  }

  Widget _buildStep1PersonalData() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.person_outline, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                'Datos Personales',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nombre'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Juan',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Apellido'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        hintText: 'Pérez',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Icon(Icons.phone_outlined),
              SizedBox(width: 8),
              Text('Teléfono'),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              hintText: '301 234 5678',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  Widget _buildStep2Address() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.location_on_outlined, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                'Dirección del Servicio',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Dirección completa'),
          const SizedBox(height: 8),
          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(
              hintText: 'Calle 123 #45-67, Barrio...',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 20),
          const Text('Ciudad'),
          const SizedBox(height: 8),
          TextFormField(
            controller: _cityController,
            decoration: const InputDecoration(
              hintText: 'Bogotá',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep3DateTime() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.schedule_outlined, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                'Fecha y Hora',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Fecha'),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: _selectDate,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              _selectedDate == null
                                  ? 'Seleccionar fecha'
                                  : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Hora'),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: _selectTime,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              _selectedTime == null
                                  ? 'Seleccionar hora'
                                  : '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Observaciones (opcional)'),
          const SizedBox(height: 8),
          TextFormField(
            controller: _observationsController,
            decoration: const InputDecoration(
              hintText: 'Detalles adicionales sobre el servicio...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.phone, color: Colors.grey),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Te contactaremos en las próximas 2 horas para confirmar tu cita',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
                child: const Text('Atrás'),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: _currentStep == 2 ? _confirmBooking : _nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                _currentStep == 2
                    ? 'Confirmar Reserva'
                    : _currentStep == 1
                        ? 'Continuar a Fecha'
                        : 'Continuar a Dirección',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
