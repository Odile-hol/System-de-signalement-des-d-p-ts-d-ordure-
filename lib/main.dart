import 'package:flutter/material.dart';
import 'package:cleancity/home_page.dart';
import 'package:firebase_core/firebase_core.dart'; // Ajout du point-virgule ici ;)

// On ajoute "async" pour permettre d'attendre Firebase
void main() async {
  // 1. Cette ligne est OBLIGATOIRE pour Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // 2. On attend que Firebase s'initialise
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cleancity',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
