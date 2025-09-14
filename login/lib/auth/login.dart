import 'package:flutter/material.dart';
import '../../widgets/appbar.dart';
import '../home/home.dart';
import '../user/form.dart';
import '../utils/validation_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Constantes para los textos
  static const String _title = 'Iniciar Sesión';
  static const String _emailLabel = 'Correo Electrónico';
  static const String _emailHint = 'ejemplo@correo.com';
  static const String _passwordLabel = 'Contraseña';
  static const String _passwordHelper =
      '8-16 caracteres, mayúscula, minúscula, número y carácter especial';
  static const String _loginButton = 'Ingresar';
  static const String _registerButton = '¿No tienes cuenta? Regístrate aquí';
  static const String _successMessage = 'Usuario registrado exitosamente';
  static const String _logoPath = 'assets/img/logos/proyectoL.jpeg';

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _navigateToRegister() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserFormScreen()),
    );

    if (result != null && result is Map<String, String>) {
      _usernameController.text = result['username'] ?? '';
      _passwordController.text = result['password'] ?? '';

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(_successMessage)),
        );
      }
    }
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = _usernameController.text;
      final password = _passwordController.text;

      // Capturar los datos en un array
      final loginData = [
        {
          'campo': 'Email',
          'valor': email,
          'timestamp': DateTime.now().toString(),
        },
        {
          'campo': 'Password',
          'valor': '****** (oculto por seguridad)',
          'longitudPassword': password.length,
          'timestamp': DateTime.now().toString(),
        }
      ];

      // Mostrar los datos en consola
      debugPrint(' DATOS DE INICIO DE SESIÓN ');
      // debugPrint('Array de datos capturados:');
      for (int i = 0; i < loginData.length; i++) {
        debugPrint('Índice [$i]: ${loginData[i]}');
      }
      debugPrint('Email completo: $email');
      debugPrint('Usuario extraído: ${email.split('@')[0]}');
      debugPrint('Dominio extraído: ${email.split('@')[1]}');
      debugPrint('Longitud de contraseña: ${password.length} caracteres');
      debugPrint('Fecha y hora de login: ${DateTime.now()}');
     // debugPrint('================================');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(email: email, password: password),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: _title),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(),
              const SizedBox(height: 20),
              _buildEmailField(),
              const SizedBox(height: 20),
              _buildPasswordField(),
              const SizedBox(height: 30),
              _buildLoginButton(),
              const SizedBox(height: 20),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      _logoPath,
      height: 100,
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _usernameController,
      decoration: const InputDecoration(
        labelText: _emailLabel,
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(),
        hintText: _emailHint,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: ValidationUtils.validateEmail,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(
        labelText: _passwordLabel,
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(),
        helperText: _passwordHelper,
      ),
      obscureText: true,
      validator: ValidationUtils.validatePassword,
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _login,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text(_loginButton),
    );
  }

  Widget _buildRegisterButton() {
    return TextButton(
      onPressed: _navigateToRegister,
      child: const Text(_registerButton),
    );
  }
}
