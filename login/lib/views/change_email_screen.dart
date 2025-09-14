import 'package:flutter/material.dart';
import '../widgets/appbar.dart';
import '../utils/validation_utils.dart';

class ChangeEmailScreen extends StatefulWidget {
  final String currentEmail;
  final String username;

  const ChangeEmailScreen({
    super.key,
    required this.currentEmail,
    required this.username,
  });

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentEmailController = TextEditingController();
  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentEmailController.text = widget.currentEmail;
  }

  @override
  void dispose() {
    _currentEmailController.dispose();
    _newEmailController.dispose();
    _confirmEmailController.dispose();
    super.dispose();
  }

  void _changeEmail() {
    if (_formKey.currentState!.validate()) {
      // Verificar que el nuevo email sea diferente al actual
      if (_newEmailController.text == _currentEmailController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El nuevo correo debe ser diferente al actual'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // Aquí implementarías la lógica para cambiar el email
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email actualizado a: ${_newEmailController.text}'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Cambiar Email',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Actualiza tu dirección de correo electrónico',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _currentEmailController,
                decoration: const InputDecoration(
                  labelText: 'Correo actual',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                enabled: false,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _newEmailController,
                decoration: const InputDecoration(
                  labelText: 'Nuevo correo electrónico',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  hintText: 'ejemplo@correo.com',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: ValidationUtils.validateEmail,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _confirmEmailController,
                decoration: const InputDecoration(
                  labelText: 'Confirmar nuevo correo',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                  hintText: 'Confirma tu nuevo correo',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => ValidationUtils.validateConfirmEmail(
                  value,
                  _newEmailController.text,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _changeEmail,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text('Actualizar Email'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
