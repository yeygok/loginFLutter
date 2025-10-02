import 'package:flutter/material.dart';
import '../widgets/appbar.dart';
import '../widgets/navigation_drawer.dart';
import '../widgets/navigation_bottom.dart';
import '../user/user.dart';
import '../views/settings_screen.dart';
import '../views/reservations_screen.dart';
import '../views/my_reservations_screen.dart';
import '../views/api_test_screen.dart';
import '../views/my_appointments_screen.dart';
import '../views/create_appointment_screen.dart';
import '../auth/login.dart';

// primer commit
class HomeScreen extends StatefulWidget {
  final String email;
  final String password;

  const HomeScreen({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late List<Widget> _pages;

  // Función helper para extraer el username del email
  String get username {
    return widget.email.split('@')[0];
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeContent(username: username), // 0: Inicio
      UserScreen(email: widget.email, password: widget.password), // 1: Perfil
      SettingsScreen(
        // 2: Configuración
        currentEmail: widget.email,
        username: username,
      ),
      const MyAppointmentsScreen(), // 3: Mis Citas (NUEVO)
      const ReservationsScreen(), // 4: Agendar Servicios
      const MyReservationsScreen(), // 5: Mis Reservas
      const ApiTestScreen(), // 6: Pruebas API
      _buildPlaceholderPage('Ayuda', Icons.help), // 7: Ayuda
      _buildPlaceholderPage('Acerca de', Icons.info), // 8: Acerca de
    ];
  }

  void _onDrawerItemSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
    _scaffoldKey.currentState?.closeDrawer();
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: _getTitle(),
        showBackButton: false,
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      drawer: CustomDrawer(
        email: widget.email,
        onItemSelected: _onDrawerItemSelected,
        onLogout: _logout,
        currentIndex: _currentIndex,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex > 2
            ? 0
            : _currentIndex, // Solo resalta si es 0, 1 o 2
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildPlaceholderPage(String title, IconData icon) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              Text(
                'Página en desarrollo',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Inicio';
      case 1:
        return 'Perfil';
      case 2:
        return 'Configuración';
      case 3:
        return 'Mis Citas';
      case 4:
        return 'Agendar Servicios';
      case 5:
        return 'Mis Reservas';
      case 6:
        return 'Pruebas API';
      case 7:
        return 'Ayuda';
      case 8:
        return 'Acerca de';
      default:
        return 'Mi App';
    }
  }
}

class HomeContent extends StatelessWidget {
  final String username;

  const HomeContent({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¡Bienvenido, $username!',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(height: 16),

            // TARJETA DESTACADA: AGENDAR CITA
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4285F4), Color(0xFF34A853)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.local_car_wash,
                            color: Colors.white, size: 40),
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
                                'Lavado a vapor profesional',
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
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CreateAppointmentScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF4285F4),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.add_circle_outline),
                        label: const Text(
                          'Agendar Cita',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(Icons.info_outline,
                        size: 45, color: Colors.blue),
                    const SizedBox(height: 8),
                    const Text(
                      'Bienvenido a la aplicación de MEGA LAVADO',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Agenda tu servicio de lavado a vapor a domicilio de forma rápida y sencilla.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth > 400 ? 2 : 2;
                double childAspectRatio =
                    constraints.maxWidth > 400 ? 1.0 : 0.9;

                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: childAspectRatio,
                  children: [
                    _buildFeatureCard(
                        Icons.event_available, 'Mis Citas', Colors.blue),
                    _buildFeatureCard(Icons.person, 'Mi Perfil', Colors.green),
                    _buildFeatureCard(
                        Icons.settings, 'Configuración', Colors.orange),
                    _buildFeatureCard(
                        Icons.help_outline, 'Ayuda', Colors.purple),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
