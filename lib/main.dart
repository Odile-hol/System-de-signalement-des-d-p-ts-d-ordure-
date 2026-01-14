import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Imports de vos fichiers locaux
import 'home_page.dart';
import 'pages/auth/sing_up_page.dart'; // Correction de l'orthographe ici

void main() async {
  // 1. Initialisation des composants Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Connexion au Backend (BaaS Firebase) optimisée pour le Web
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCogHRojEXiKakKq2E1ufAUtSPtK32PEcM",
      authDomain: "cleancity-d349f.firebaseapp.com",
      projectId: "cleancity-d349f",
      storageBucket: "cleancity-d349f.firebasestorage.app",
      messagingSenderId: "294501636780",
      appId: "1:294501636780:web:bcd275bcdbb7e4e6111d09",
      measurementId: "G-6PCXW8C2KB",
    ),
  );

  // 3. Lancement de l'application
  runApp(const CleanCityApp());
}

// --- LA CLASSE PRINCIPALE ---
class CleanCityApp extends StatelessWidget {
  const CleanCityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CleanCity Yaoundé',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Design Vert Écologique CleanCity
        primarySwatch: Colors.green,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      // AuthWrapper décide quelle page afficher au démarrage
      home: const AuthWrapper(),
    );
  }
}

// --- GESTION AUTOMATIQUE DE LA CONNEXION (Pattern Observer) ---
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Si l'utilisateur est déjà connecté (session active)
        if (snapshot.hasData) {
          return const HomePage();
        }
        // Sinon, redirection vers l'inscription/connexion
        return const SignUpPage();
      },
    );
  }
}
