import 'package:flutter/material.dart';
import 'splash/splash_app.dart';
import 'theme/yeygokstilo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YeygokApp - Flutter Login',
      theme: YeygokEstilo.temaClaro,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
