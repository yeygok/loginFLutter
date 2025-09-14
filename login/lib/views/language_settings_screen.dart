import 'package:flutter/material.dart';
import '../widgets/appbar.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  String _selectedLanguage = 'Español';

  final List<Map<String, String>> _languages = [
    {'code': 'es', 'name': 'Español', 'flag': '🇪🇸'},
    {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
    {'code': 'fr', 'name': 'Français', 'flag': '🇫🇷'},
    {'code': 'pt', 'name': 'Português', 'flag': '🇧🇷'},
    {'code': 'it', 'name': 'Italiano', 'flag': '🇮🇹'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Idioma',
        showBackButton: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Selecciona el idioma de la aplicación',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _languages.length,
              itemBuilder: (context, index) {
                final language = _languages[index];
                final isSelected = _selectedLanguage == language['name'];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Text(
                        language['flag']!,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    title: Text(
                      language['name']!,
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text(language['code']!.toUpperCase()),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const Icon(Icons.radio_button_unchecked,
                            color: Colors.grey),
                    onTap: () {
                      setState(() {
                        _selectedLanguage = language['name']!;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Idioma cambiado a: ${language['name']}'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Idioma $_selectedLanguage aplicado'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Aplicar Cambios'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
