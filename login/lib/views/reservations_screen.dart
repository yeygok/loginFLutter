import 'package:flutter/material.dart';
import 'booking_flow.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  final List<Map<String, dynamic>> _services = [
    {
      'name': 'Lavado de Colchón',
      'icon': Icons.bed,
      'image': 'assets/img/services/colchon.jpg',
      'description':
          'Limpieza profunda con vapor para eliminar ácaros, bacterias y malos olores de tu colchón.',
      'levels': '3 niveles',
      'rating': 5,
      'plans': [
        {
          'name': 'Sencillo',
          'price': 25000,
          'color': Colors.grey[100],
          'popular': false,
          'features': ['Limpieza básica', 'Desinfección', 'Secado rápido']
        },
        {
          'name': 'Premium',
          'price': 40000,
          'color': Colors.blue[50],
          'popular': true,
          'features': [
            'Limpieza profunda',
            'Desinfección',
            'Tratamiento anti-ácaros',
            'Perfumado'
          ]
        },
        {
          'name': 'Golden',
          'price': 60000,
          'color': Colors.yellow[50],
          'popular': false,
          'features': [
            'Limpieza profunda',
            'Desinfección total',
            'Anti-ácaros',
            'Perfumado premium',
            'Protección UV'
          ]
        }
      ]
    },
    {
      'name': 'Lavado de Automóvil',
      'icon': Icons.directions_car,
      'image': 'assets/img/services/carro.jpg',
      'description':
          'Lavado completo de tu vehículo con tecnología de vapor ecológica y productos premium.',
      'levels': '3 niveles',
      'rating': 5,
      'plans': [
        {
          'name': 'Sencillo',
          'price': 30000,
          'color': Colors.grey[100],
          'popular': false,
          'features': ['Lavado exterior', 'Aspirado básico', 'Llantas']
        },
        {
          'name': 'Premium',
          'price': 50000,
          'color': Colors.blue[50],
          'popular': true,
          'features': [
            'Lavado completo',
            'Aspirado profundo',
            'Tablero',
            'Llantas',
            'Cera'
          ]
        },
        {
          'name': 'Golden',
          'price': 80000,
          'color': Colors.yellow[50],
          'popular': false,
          'features': [
            'Lavado completo',
            'Aspirado profundo',
            'Encerado premium',
            'Motor',
            'Perfumado'
          ]
        }
      ]
    }
  ];

  void _scheduleService(String serviceName, String planName, int price) {
    // Determinar el serviceTypeId basado en el nombre del servicio
    int serviceTypeId = 1; // Default
    if (serviceName.contains('Colchón')) {
      serviceTypeId = 1; // ID para lavado de colchón
    } else if (serviceName.contains('Automóvil')) {
      serviceTypeId = 2; // ID para lavado de automóvil
    }

    showDialog(
      context: context,
      builder: (context) => BookingFlow(
        serviceName: serviceName,
        planName: planName,
        price: price,
        serviceTypeId: serviceTypeId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Nuestros Servicios'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Center(
              child: Text(
                'Elige el servicio perfecto para ti',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Services List
            ..._services.map((service) => _buildServiceCard(service)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Header with Image
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[300],
              image: const DecorationImage(
                image: NetworkImage(
                    'https://via.placeholder.com/400x200/4CAF50/FFFFFF?text=Servicio'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          service['icon'],
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          service['levels'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    service['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Servicio profesional a vapor',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(
                        5,
                        (index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            )),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Service Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              service['description'],
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),

          // Plans
          ...service['plans']
              .map<Widget>((plan) => _buildPlanCard(service['name'], plan))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildPlanCard(String serviceName, Map<String, dynamic> plan) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: plan['color'],
        borderRadius: BorderRadius.circular(12),
        border:
            plan['popular'] ? Border.all(color: Colors.blue, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (plan['popular'])
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: Colors.white, size: 12),
                              SizedBox(width: 4),
                              Text(
                                'Más Popular',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    plan['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${plan['price'].toString().replaceAllMapped(RegExp(r'\d{1,3}(?=(\d{3})+(?!\d))'), (Match m) => '${m[0]},')}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () =>
                    _scheduleService(serviceName, plan['name'], plan['price']),
                icon: const Icon(Icons.calendar_month, size: 16),
                label: const Text('Agendar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...plan['features']
              .map<Widget>((feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.check, color: Colors.green, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          feature,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
