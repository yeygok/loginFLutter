import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_config.dart';
import '../providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class ApiTestScreen extends StatefulWidget {
  const ApiTestScreen({super.key});

  @override
  State<ApiTestScreen> createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  final TextEditingController _emailController =
      TextEditingController(text: 'test@example.com');
  final TextEditingController _passwordController =
      TextEditingController(text: 'test123');
  final TextEditingController _customUrlController = TextEditingController();

  String _responseText = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _customUrlController.dispose();
    super.dispose();
  }

  Future<void> _testLogin() async {
    setState(() {
      _isLoading = true;
      _responseText = '🔄 Probando login...\n\n';
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final success = await authProvider.login(
        _emailController.text,
        _passwordController.text,
      );

      setState(() {
        _responseText +=
            success ? '✅ Login exitoso!\n\n' : '❌ Login fallido\n\n';
        _responseText +=
            'Mensaje: ${authProvider.errorMessage ?? "Sin mensaje de error"}\n\n';
        if (authProvider.currentUser != null) {
          _responseText += '👤 Usuario: ${authProvider.currentUser!.name}\n';
          _responseText += '📧 Email: ${authProvider.currentUser!.email}\n';
          _responseText += '🆔 ID: ${authProvider.currentUser!.id}\n';
        }
      });
    } catch (e) {
      setState(() {
        _responseText += '❌ Error: $e\n';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testConnectivity() async {
    setState(() {
      _isLoading = true;
      _responseText = '🔄 Probando conectividad...\n\n';
    });

    try {
      final url = Uri.parse(AppConfig.baseUrl);
      _responseText += '🌐 Probando conexión a: ${AppConfig.baseUrl}\n\n';

      final startTime = DateTime.now();
      final response = await http.get(url).timeout(const Duration(seconds: 10));
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      setState(() {
        _responseText += '✅ Conexión exitosa!\n';
        _responseText += '⏱️ Tiempo: ${duration.inMilliseconds}ms\n';
        _responseText += '📊 Status: ${response.statusCode}\n';
      });
    } catch (e) {
      setState(() {
        _responseText += '❌ Error de conectividad: $e\n';
        _responseText += '\n💡 Posibles causas:\n';
        _responseText += '  • El servidor no está ejecutándose\n';
        _responseText += '  • La IP ${AppConfig.baseUrl} no es accesible\n';
        _responseText += '  • Problemas de red o firewall\n';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _clearResponse() {
    setState(() {
      _responseText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🧪 Pruebas de API'),
        backgroundColor: const Color(0xFF4285F4),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearResponse,
            tooltip: 'Limpiar respuesta',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Información de configuración
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '⚙️ Configuración Actual',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('🌐 Base URL: ${AppConfig.baseUrl}'),
                    Text('🔑 Login URL: ${AppConfig.loginUrl}'),
                    Text('⏱️ Timeout: ${AppConfig.apiTimeout.inSeconds}s'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Campos de entrada
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📝 Datos de Prueba (Modo Testing)',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '💡 Emails con "test" o "admin" hacen login automático',
                      style: TextStyle(fontSize: 12, color: Colors.green),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña (opcional)',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Botones de prueba
            const Text(
              '🧪 Pruebas Disponibles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _testConnectivity,
                  icon: const Icon(Icons.wifi),
                  label: const Text('Conectividad'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _testLogin,
                  icon: const Icon(Icons.login),
                  label: const Text('Login Testing'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Indicador de carga
            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              ),

            // Área de respuesta
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📄 Respuesta',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 300,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: SingleChildScrollView(
                        child: SelectableText(
                          _responseText.isEmpty
                              ? '👆 Selecciona una prueba para ver la respuesta aquí'
                              : _responseText,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Información de ayuda
            Card(
              color: Colors.blue[50],
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '💡 Modo Testing Activado',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                        '• Cualquier email con "test" o "admin" hace login automático'),
                    Text('• No requiere contraseña ni servidor API'),
                    Text('• Perfecto para probar la UI sin backend'),
                    Text(
                        '• Una vez que tu API esté lista, quita el modo testing'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
