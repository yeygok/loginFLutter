import 'package:flutter/material.dart';

class YeygokEstilo {
  // Colores personalizados
  static const Color verdeOscuro = Color(0xFF0D4A1E);
  static const Color verdeClaro = Color(0xFF2E7D32);
  static const Color verdeAccent = Color(0xFF4CAF50);
  static const Color negro = Color(0xFF000000);
  static const Color negroSuave = Color(0xFF212121);
  static const Color blanco = Color(0xFFFFFFFF);
  static const Color grisClaro = Color(0xFFF5F5F5);
  static const Color grisOscuro = Color(0xFF757575);

  // Tema claro personalizado
  static ThemeData get temaClaro {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Esquema de colores principal
      colorScheme: const ColorScheme.light(
        primary: verdeClaro,
        primaryContainer: verdeOscuro,
        secondary: verdeAccent,
        secondaryContainer: verdeClaro,
        surface: blanco,
        background: grisClaro,
        error: Colors.red,
        onPrimary: blanco,
        onSecondary: blanco,
        onSurface: negro,
        onBackground: negro,
        onError: blanco,
      ),

      // AppBar personalizado
      appBarTheme: const AppBarTheme(
        backgroundColor: verdeClaro,
        foregroundColor: blanco,
        elevation: 4,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: blanco,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: blanco),
      ),

      // Botones elevados
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: verdeClaro,
          foregroundColor: blanco,
          elevation: 3,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Botones de texto
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: verdeClaro,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Campos de texto
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: grisOscuro),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: grisOscuro),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: verdeClaro, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        labelStyle: const TextStyle(color: grisOscuro),
        helperStyle: const TextStyle(color: grisOscuro, fontSize: 12),
        hintStyle: const TextStyle(color: grisOscuro),
        prefixIconColor: verdeClaro,
        suffixIconColor: verdeClaro,
      ),

      // Cards
      cardTheme: CardTheme(
        color: blanco,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(8),
      ),

      // Drawer
      drawerTheme: const DrawerThemeData(
        backgroundColor: blanco,
        elevation: 4,
      ),

      // Lista de elementos
      listTileTheme: const ListTileThemeData(
        selectedTileColor: Color(0xFFE8F5E8),
        selectedColor: verdeOscuro,
        iconColor: grisOscuro,
        textColor: negro,
      ),

      // SnackBar
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: verdeOscuro,
        contentTextStyle: TextStyle(color: blanco),
        actionTextColor: verdeAccent,
      ),

      // FloatingActionButton
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: verdeClaro,
        foregroundColor: blanco,
      ),

      // BottomNavigationBar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: blanco,
        selectedItemColor: verdeClaro,
        unselectedItemColor: grisOscuro,
        type: BottomNavigationBarType.fixed,
      ),

      // Typography
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: negro, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: negro, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: negro, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(color: negro, fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(color: negro, fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(color: negro, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: negro, fontWeight: FontWeight.w500),
        titleMedium: TextStyle(color: negro, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(color: negro, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: negro),
        bodyMedium: TextStyle(color: negro),
        bodySmall: TextStyle(color: grisOscuro),
        labelLarge: TextStyle(color: negro, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(color: negro),
        labelSmall: TextStyle(color: grisOscuro),
      ),
    );
  }

  // Tema oscuro personalizado
  static ThemeData get temaOscuro {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Esquema de colores para tema oscuro
      colorScheme: const ColorScheme.dark(
        primary: verdeAccent,
        primaryContainer: verdeClaro,
        secondary: verdeClaro,
        secondaryContainer: verdeOscuro,
        surface: negroSuave,
        background: negro,
        error: Colors.redAccent,
        onPrimary: negro,
        onSecondary: negro,
        onSurface: blanco,
        onBackground: blanco,
        onError: negro,
      ),

      // AppBar para tema oscuro
      appBarTheme: const AppBarTheme(
        backgroundColor: negro,
        foregroundColor: blanco,
        elevation: 4,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: blanco,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: blanco),
      ),

      // Botones elevados para tema oscuro
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: verdeAccent,
          foregroundColor: negro,
          elevation: 3,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Cards para tema oscuro
      cardTheme: CardTheme(
        color: negroSuave,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(8),
      ),

      // Drawer para tema oscuro
      drawerTheme: const DrawerThemeData(
        backgroundColor: negroSuave,
        elevation: 4,
      ),

      // Typography para tema oscuro
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: blanco, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: blanco, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: blanco, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(color: blanco, fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(color: blanco, fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(color: blanco, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: blanco, fontWeight: FontWeight.w500),
        titleMedium: TextStyle(color: blanco, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(color: blanco, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: blanco),
        bodyMedium: TextStyle(color: blanco),
        bodySmall: TextStyle(color: grisClaro),
        labelLarge: TextStyle(color: blanco, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(color: blanco),
        labelSmall: TextStyle(color: grisClaro),
      ),
    );
  }

  // Gradientes personalizados
  static const LinearGradient gradienteVerde = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [verdeClaro, verdeOscuro],
  );

  static const LinearGradient gradienteVerdeClaro = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [verdeAccent, verdeClaro],
  );

  // Sombras personalizadas
  static List<BoxShadow> get sombraVerde => [
        BoxShadow(
          color: verdeClaro.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get sombraNegra => [
        BoxShadow(
          color: negro.withOpacity(0.2),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ];

  // Decoraciones especiales
  static BoxDecoration get contenedorVerde => BoxDecoration(
        gradient: gradienteVerde,
        borderRadius: BorderRadius.circular(12),
        boxShadow: sombraVerde,
      );

  static BoxDecoration get contenedorBlanco => BoxDecoration(
        color: blanco,
        borderRadius: BorderRadius.circular(12),
        boxShadow: sombraNegra,
      );
}
