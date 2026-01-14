import 'package:flutter/material.dart';
import 'core/user_session.dart';
import 'pages/citizen/citizen_main.dart';
import 'pages/team/team_tasks.dart';
import 'pages/admin/admin_panel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupération du rôle via le Singleton UserSession
    final String role = UserSession.instance.userRole ?? "Citoyen";

    // Navigation basée sur le rôle (Factory Pattern simplifié)
    switch (role) {
      case 'Admin':
        return const AdminPanel();
      case 'Equipe de nettoyage':
        return const TeamTasksPage();
      case 'Citoyen':
      default:
        return const CitizenMainPage();
    }
  }
}
