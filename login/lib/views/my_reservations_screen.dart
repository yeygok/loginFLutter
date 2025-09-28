import 'package:flutter/material.dart';

class MyReservationsScreen extends StatelessWidget {
  const MyReservationsScreen({super.key});

  // Mock data for detailed reservations with technician and vehicle info
  final List<Map<String, dynamic>> _reservations = const [
    {
      'id': 'RES-001',
      'service': 'Lavado de Carro',
      'type': 'Premium',
      'price': 25000,
      'date': '2025-09-30',
      'time': '10:00 AM',
      'status': 'Confirmado',
      'technician': {
        'name': 'Carlos Rodríguez',
        'phone': '+57 300 123 4567',
        'rating': 4.8,
        'experience': '5 años',
        'photo': 'assets/img/technician1.jpg',
      },
      'vehicle': {
        'brand': 'Toyota',
        'model': 'Hilux',
        'plate': 'ABC-123',
        'color': 'Blanco',
        'year': '2022',
      },
      'address': 'Carrera 15 #45-30, Bogotá',
      'notes': 'Incluye encerado y aspirado completo',
    },
    {
      'id': 'RES-002',
      'service': 'Lavado de Colchón',
      'type': 'Gold',
      'price': 45000,
      'date': '2025-10-05',
      'time': '2:00 PM',
      'status': 'Pendiente',
      'technician': {
        'name': 'María González',
        'phone': '+57 301 987 6543',
        'rating': 4.9,
        'experience': '3 años',
        'photo': 'assets/img/technician2.jpg',
      },
      'vehicle': {
        'brand': 'Chevrolet',
        'model': 'N300',
        'plate': 'DEF-456',
        'color': 'Azul',
        'year': '2021',
      },
      'address': 'Calle 80 #12-25, Bogotá',
      'notes': 'Colchón queen size, tratamiento anti-ácaros',
    },
    {
      'id': 'RES-003',
      'service': 'Lavado de Alfombra',
      'type': 'Sencillo',
      'price': 15000,
      'date': '2025-09-25',
      'time': '9:00 AM',
      'status': 'Completado',
      'technician': {
        'name': 'Luis Martínez',
        'phone': '+57 302 456 7890',
        'rating': 4.7,
        'experience': '4 años',
        'photo': 'assets/img/technician3.jpg',
      },
      'vehicle': {
        'brand': 'Renault',
        'model': 'Master',
        'plate': 'GHI-789',
        'color': 'Gris',
        'year': '2020',
      },
      'address': 'Avenida 68 #30-15, Bogotá',
      'notes': 'Alfombra persa 2x3 metros',
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmado':
        return Colors.green;
      case 'Pendiente':
        return Colors.orange;
      case 'Completado':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Confirmado':
        return Icons.check_circle;
      case 'Pendiente':
        return Icons.access_time;
      case 'Completado':
        return Icons.verified;
      default:
        return Icons.info;
    }
  }

  String _formatPrice(int price) {
    return '\$${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _reservations.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _reservations.length,
              itemBuilder: (context, index) {
                final reservation = _reservations[index];
                return _buildReservationCard(context, reservation, index);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          const Text(
            '¡No tienes reservas aún!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Cuando realices una reserva, aparecerá aquí con todos los detalles',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationCard(
      BuildContext context, Map<String, dynamic> reservation, int index) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              _getStatusColor(reservation['status']).withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          children: [
            _buildReservationHeader(reservation),
            _buildReservationDetails(reservation),
            _buildTechnicianInfo(reservation),
            _buildVehicleInfo(reservation),
            _buildPriceSection(reservation),
            _buildThankYouMessage(reservation),
          ],
        ),
      ),
    );
  }

  Widget _buildReservationHeader(Map<String, dynamic> reservation) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _getStatusColor(reservation['status']).withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getStatusColor(reservation['status']),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getStatusIcon(reservation['status']),
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reservation['service'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        reservation['type'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(reservation['status'])
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        reservation['status'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(reservation['status']),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            'ID: ${reservation['id']}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationDetails(Map<String, dynamic> reservation) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildDetailRow(Icons.calendar_today, 'Fecha', reservation['date']),
          const SizedBox(height: 12),
          _buildDetailRow(Icons.access_time, 'Hora', reservation['time']),
          const SizedBox(height: 12),
          _buildDetailRow(
              Icons.location_on, 'Dirección', reservation['address']),
          const SizedBox(height: 12),
          _buildDetailRow(Icons.notes, 'Notas', reservation['notes']),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTechnicianInfo(Map<String, dynamic> reservation) {
    final technician = reservation['technician'];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person, color: Colors.blue, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Técnico Asignado',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue.withOpacity(0.2),
                child: const Icon(Icons.person, color: Colors.blue, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      technician['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${technician['rating']} ⭐',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${technician['experience']} exp.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.green, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          technician['phone'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleInfo(Map<String, dynamic> reservation) {
    final vehicle = reservation['vehicle'];
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.directions_car, color: Colors.green, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Vehículo del Técnico',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.local_shipping,
                    color: Colors.green, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${vehicle['brand']} ${vehicle['model']} ${vehicle['year']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Placa: ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          vehicle['plate'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Color: ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          vehicle['color'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection(Map<String, dynamic> reservation) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total a Pagar',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatPrice(reservation['price']),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.receipt,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThankYouMessage(Map<String, dynamic> reservation) {
    String message = '';
    IconData icon = Icons.favorite;
    Color color = Colors.pink;

    switch (reservation['status']) {
      case 'Confirmado':
        message =
            '¡Gracias por tu reserva! Nuestro técnico llegará puntualmente.';
        icon = Icons.schedule;
        color = Colors.green;
        break;
      case 'Pendiente':
        message = '¡Gracias por elegirnos! Estamos procesando tu solicitud.';
        icon = Icons.pending;
        color = Colors.orange;
        break;
      case 'Completado':
        message = '¡Servicio completado! Gracias por confiar en nosotros.';
        icon = Icons.check_circle;
        color = Colors.blue;
        break;
    }

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14,
                color: color.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
