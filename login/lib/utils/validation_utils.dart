class ValidationUtils {
  // Validación de nombre
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su nombre';
    }

    if (value.length < 2) {
      return 'El nombre debe tener al menos 2 caracteres';
    }

    if (value.length > 50) {
      return 'El nombre no puede tener más de 50 caracteres';
    }

    // Solo permite letras, espacios y acentos
    if (!RegExp(r'^[a-zA-ZÀ-ÿ\u00f1\u00d1\s]+$').hasMatch(value)) {
      return 'El nombre solo puede contener letras';
    }

    return null;
  }

  // Validación de teléfono
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su número de teléfono';
    }

    // Remover espacios y caracteres especiales para validación
    String cleanPhone = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Validar que solo contenga números
    if (!RegExp(r'^\d+$').hasMatch(cleanPhone)) {
      return 'El teléfono solo puede contener números';
    }

    // Validar longitud para números colombianos (10 dígitos)
    if (cleanPhone.length != 10) {
      return 'El teléfono debe tener 10 dígitos';
    }

    // Validar que comience con 3 (celulares colombianos)
    if (!cleanPhone.startsWith('3')) {
      return 'El número debe comenzar con 3 (celular)';
    }

    return null;
  }

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

  // Validación de contraseña (simple, mínimo 6 caracteres)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese una contraseña';
    }

    // Verificar longitud mínima (6 caracteres como requiere el backend)
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
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
    return 'La contraseña debe tener al menos 6 caracteres';
  }
}
