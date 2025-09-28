import 'package:flutter/material.dart';

class YeygokEstilo {
  // Paleta de colores minimalista
  static const Color verdeClaro = Color(0xFF4CAF50); // Verde principal
  static const Color verdeOscuro = Color(0xFF2E7D32); // Verde oscuro
  static const Color verdeAccent = Color(0xFF81C784); // Verde suave
  static const Color verdeSuave = Color(0xFFE8F5E8); // Verde muy claro

  static const Color negro = Color(0xFF000000);
  static const Color blanco = Color(0xFFFFFFFF);
  static const Color grisClaro = Color(0xFFF8F9FA);
  static const Color grisOscuro = Color(0xFF6C757D);
  static const Color grisMedio = Color(0xFFDEE2E6);

  // Tema principal simplificado
  static ThemeData get temaClaro {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Esquema de colores
      colorScheme: const ColorScheme.light(
        primary: verdeClaro,
        secondary: verdeAccent,
        surface: blanco,
        onPrimary: blanco,
        onSecondary: negro,
        onSurface: negro,
      ),

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: verdeClaro,
        foregroundColor: blanco,
        elevation: 2,
        centerTitle: true,
      ),

      // Botones
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: verdeClaro,
          foregroundColor: blanco,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Campos de texto
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: verdeClaro, width: 2),
        ),
      ),

      // Texto
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: negro,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: negro,
        ),
      ),
    );
  }

  static ThemeData get temaOscuro {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Esquema de colores
      colorScheme: const ColorScheme.dark(
        primary: verdeOscuro,
        secondary: verdeAccent,
        surface: Color(0xFF1E1E1E),
        onPrimary: blanco,
        onSecondary: negro,
        onSurface: blanco,
      ),

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: verdeOscuro,
        foregroundColor: blanco,
        elevation: 2,
        centerTitle: true,
      ),

      // Botones
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: verdeOscuro,
          foregroundColor: blanco,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Campos de texto
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: verdeOscuro, width: 2),
        ),
      ),

      // Texto
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: blanco,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: blanco,
        ),
      ),
    );
  }

  // Funciones auxiliares para el drawer
  static BoxDecoration get headerDrawer => const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [verdeClaro, verdeAccent],
        ),
      );

  static Color get drawerBackgroundColor => grisClaro;
}
