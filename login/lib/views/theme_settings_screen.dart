import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/appbar.dart';
import '../theme/theme_provider.dart';

class ThemeSettingsScreen extends StatefulWidget {
  const ThemeSettingsScreen({super.key});

  @override
  State<ThemeSettingsScreen> createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
                  title: const Text('Modo oscuro'),
                  subtitle: Text(themeProvider.isDarkMode
                      ? 'Tema oscuro activo'
                      : 'Tema claro activo'),
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
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
                  trailing: !themeProvider.isDarkMode
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    themeProvider.toggleTheme(false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tema cambiado a claro'),
                        backgroundColor: Colors.amber,
                      ),
                    );
                  },
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
                  trailing: themeProvider.isDarkMode
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    themeProvider.toggleTheme(true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tema cambiado a oscuro'),
                        backgroundColor: Colors.indigo,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
