import 'package:flutter/material.dart';
import '../theme/yeygokstilo.dart';

class CustomDrawer extends StatelessWidget {
  final String email;
  final Function(int) onItemSelected;
  final VoidCallback onLogout;
  final int currentIndex;

  const CustomDrawer({
    super.key,
    required this.email,
    required this.onItemSelected,
    required this.onLogout,
    required this.currentIndex,
  });

  String get username => email.split('@')[0];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: YeygokEstilo.drawerBackgroundColor,
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: _buildMenuItems(),
          ),
          _buildLogoutSection(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return DrawerHeader(
      decoration: YeygokEstilo.headerDrawer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: YeygokEstilo.blanco,
            child: Icon(
              Icons.person,
              size: 35,
              color: YeygokEstilo.verdeClaro,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            username,
            style: const TextStyle(
              color: YeygokEstilo.blanco,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            email,
            style: TextStyle(
              color: YeygokEstilo.blanco.withValues(alpha: 0.9),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        _buildMenuItem(Icons.home_outlined, 'Inicio', 0),
        _buildMenuItem(Icons.person_outline, 'Perfil', 1),
        _buildMenuItem(Icons.settings_outlined, 'Configuración', 2),
        _buildMenuItem(Icons.calendar_today_outlined, 'Agendar Servicios', 3),
        _buildMenuItem(Icons.history_outlined, 'Mis Reservas', 4),
        _buildMenuItem(Icons.notifications_outlined, 'Notificaciones', 5),
        _buildMenuItem(Icons.help_outline, 'Ayuda', 6),
        _buildMenuItem(Icons.info_outline, 'Acerca de', 7),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, int index) {
    final isSelected = currentIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? YeygokEstilo.verdeClaro : YeygokEstilo.grisOscuro,
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? YeygokEstilo.verdeOscuro : YeygokEstilo.negro,
            fontSize: 15,
          ),
        ),
        selected: isSelected,
        selectedTileColor: YeygokEstilo.verdeSuave,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: () => onItemSelected(index),
      ),
    );
  }

  Widget _buildLogoutSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: YeygokEstilo.grisMedio, width: 0.5),
        ),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.logout_outlined,
          color: Colors.red,
          size: 22,
        ),
        title: const Text(
          'Cerrar Sesión',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          onLogout();
        },
      ),
    );
  }
}
