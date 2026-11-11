
import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const QRToolkitApp());
}

class QRToolkitApp extends StatelessWidget {
  const QRToolkitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Toolkit',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
    );
  }
}
