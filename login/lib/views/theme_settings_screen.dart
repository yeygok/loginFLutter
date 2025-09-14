import 'package:flutter/material.dart';
import '../widgets/appbar.dart';

class ThemeSettingsScreen extends StatefulWidget {
  const ThemeSettingsScreen({super.key});

  @override
  State<ThemeSettingsScreen> createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  bool _isDarkMode = false;
  bool _useSystemTheme = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Tema de la App',
        showBackButton: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const Text(
            'Personaliza la apariencia de la aplicación',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Usar tema del sistema'),
                  subtitle: const Text('Seguir configuración del dispositivo'),
                  value: _useSystemTheme,
                  onChanged: (value) {
                    setState(() {
                      _useSystemTheme = value;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(_useSystemTheme
                            ? 'Usando tema del sistema'
                            : 'Usando tema personalizado'),
                      ),
                    );
                  },
                ),
                if (!_useSystemTheme) ...[
                  const Divider(),
                  SwitchListTile(
                    title: const Text('Modo oscuro'),
                    subtitle: Text(_isDarkMode
                        ? 'Tema oscuro activo'
                        : 'Tema claro activo'),
                    value: _isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Tema cambiado a modo ${value ? 'oscuro' : 'claro'}'),
                          backgroundColor: value ? Colors.indigo : Colors.amber,
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.wb_sunny, color: Colors.white),
                  ),
                  title: const Text('Tema Claro'),
                  subtitle: const Text('Fondo blanco con texto oscuro'),
                  trailing: !_useSystemTheme && !_isDarkMode
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                ),
                const Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[800],
                    child:
                        const Icon(Icons.nightlight_round, color: Colors.white),
                  ),
                  title: const Text('Tema Oscuro'),
                  subtitle: const Text('Fondo oscuro con texto claro'),
                  trailing: !_useSystemTheme && _isDarkMode
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                ),
                const Divider(),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.purple,
                    child: Icon(Icons.auto_awesome, color: Colors.white),
                  ),
                  title: const Text('Automático'),
                  subtitle: const Text('Seguir configuración del sistema'),
                  trailing: _useSystemTheme
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
