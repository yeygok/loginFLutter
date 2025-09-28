import 'package:flutter/material.dart';
import 'change_user_data_screen.dart';
import 'theme_settings_screen.dart';
import 'language_settings_screen.dart';

class SettingsScreen extends StatefulWidget {
  final String currentEmail;
  final String username;

  const SettingsScreen({
    super.key,
    required this.currentEmail,
    required this.username,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          _buildSectionHeader('Cuenta'),
          _buildSettingsList([
            _buildSettingItem(
              icon: Icons.edit,
              title: 'Actualizar Datos',
              subtitle: 'Cambia tu correo y contraseña',
              onTap: _navigateToChangeUserData,
            ),
          ]),
          const SizedBox(height: 24),
          _buildSectionHeader('Apariencia'),
          _buildSettingsList([
            _buildSettingItem(
              icon: Icons.palette,
              title: 'Tema de la App',
              subtitle: 'Personaliza colores y aspecto',
              onTap: _navigateToThemeSettings,
            ),
            _buildDivider(),
            _buildSettingItem(
              icon: Icons.language,
              title: 'Idioma',
              subtitle: 'Selecciona el idioma de la aplicación',
              onTap: _navigateToLanguageSettings,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey[600],
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingsList(List<Widget> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: items),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.blue[700],
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 72),
      child: Divider(
        height: 1,
        color: Colors.grey[200],
      ),
    );
  }

  void _navigateToChangeUserData() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeUserDataScreen(
          currentEmail: widget.currentEmail,
          username: widget.username,
        ),
      ),
    );
  }

  void _navigateToThemeSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ThemeSettingsScreen(),
      ),
    );
  }

  void _navigateToLanguageSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LanguageSettingsScreen(),
      ),
    );
  }
}
