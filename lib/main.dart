import 'package:flutter/material.dart';
import 'package:ml_zone/pages/document_scanner.dart';
import 'package:ml_zone/pages/home_page.dart';
import 'package:ml_zone/pages/image_to_text.dart';
import 'package:ml_zone/pages/splash.dart';

void main() {
  runApp(MlApp());
}

class MlApp extends StatefulWidget {
  const MlApp({super.key});

  @override
  State<MlApp> createState() => _MlAppState();
}

class _MlAppState extends State<MlApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
