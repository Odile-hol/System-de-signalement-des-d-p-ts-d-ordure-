import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'map_view.dart';
import '../profile_page.dart'; // À créer si besoin dans pages/

class CitizenMainPage extends StatefulWidget {
  const CitizenMainPage({super.key});

  @override
  State<CitizenMainPage> createState() => _CitizenMainPageState();
}

class _CitizenMainPageState extends State<CitizenMainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const CitizenDashboard(),
    const MapCleanView(),
    const Center(child: Text("Historique")),
    const Center(child: Text("Profil")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        height: 70,
        elevation: 10,
        backgroundColor: Colors.white,
        indicatorColor: Colors.green.withOpacity(0.2),
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_filled, color: Colors.green),
            label: "Accueil",
          ),
          NavigationDestination(
            icon: Icon(Icons.map_rounded, color: Colors.green),
            label: "Carte",
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics_rounded, color: Colors.green),
            label: "Suivi",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_rounded, color: Colors.green),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}
