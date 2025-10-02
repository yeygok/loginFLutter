import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash/splash_app.dart';
import 'theme/theme_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/appointment_provider.dart';
import 'config/app_config.dart';

void main() {
  // Imprimir configuración en modo debug
  AppConfig.printConfig();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => AppointmentProvider()),
      ],
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
      title: 'MEGA LAVADO S.A.S',
      theme: themeProvider.currentTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
