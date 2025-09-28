import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash/splash_app.dart';
import 'theme/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'YeygokApp - Flutter Login',
      theme: themeProvider.currentTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
