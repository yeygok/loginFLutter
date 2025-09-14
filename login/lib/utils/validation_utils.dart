class ValidationUtils {
  // Validación de email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese un correo electrónico';
    }

    // Expresión regular para validar email
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Por favor ingrese un correo electrónico válido';
    }

    return null;
  }

  // Validación de contraseña robusta
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese una contraseña';
    }

    // Verificar longitud (8-16 caracteres)
    if (value.length < 8 || value.length > 16) {
      return 'La contraseña debe tener entre 8 y 16 caracteres';
    }

    // Verificar al menos un dígito
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'La contraseña debe tener al menos un dígito';
    }

    // Verificar al menos una minúscula
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'La contraseña debe tener al menos una letra minúscula';
    }

    // Verificar al menos una mayúscula
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'La contraseña debe tener al menos una letra mayúscula';
    }

    // Verificar al menos un carácter no alfanumérico
    if (!RegExp(r'[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]').hasMatch(value)) {
      return 'La contraseña debe tener al menos un carácter especial (!@#\$%^&*...)';
    }

    return null;
  }

  // Validación para confirmar email
  static String? validateConfirmEmail(String? value, String? originalEmail) {
    if (value == null || value.isEmpty) {
      return 'Por favor confirme su correo electrónico';
    }

    if (value != originalEmail) {
      return 'Los correos electrónicos no coinciden';
    }

    // También validar que el email sea válido
    return validateEmail(value);
  }

  // Validación para confirmar contraseña
  static String? validateConfirmPassword(
      String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Por favor confirme su contraseña';
    }

    if (value != originalPassword) {
      return 'Las contraseñas no coinciden';
    }

    return null;
  }

  // Validación de contraseña actual (más simple)
  static String? validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su contraseña actual';
    }

    return null;
  }

  // Función para mostrar requisitos de contraseña
  static String getPasswordRequirements() {
    return '''La contraseña debe tener:
• Entre 8 y 16 caracteres
• Al menos un dígito (0-9)
• Al menos una minúscula (a-z)
• Al menos una mayúscula (A-Z)
• Al menos un carácter especial (!@#\$%^&*...)''';
  }
}
