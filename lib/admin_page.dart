import 'package:flutter/material.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int _selectedIndex = 0;

  // Vues simplifiées pour mobile
  final List<Widget> _adminViews = [
    const AdminStatDashboard(),
    const AdminReportsModeration(),
    const AdminAssignments(),
    const AdminUserManagement(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9),
      // --- APPBAR AVEC LOGO ---
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            const Icon(Icons.eco_rounded, color: Color(0xFF4CAF50), size: 28),
            const SizedBox(width: 8),
            const Text(
              "CleanCity",
              style: TextStyle(
                color: Color(0xFF2E3233),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded,
                color: Colors.redAccent, size: 22),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),

      // --- CONTENU ---
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _adminViews[_selectedIndex],
      ),

      // --- NAVIGATION MOBILE (EN BAS) ---
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF4CAF50),
          unselectedItemColor: Colors.grey[400],
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.analytics_outlined), label: "Stats"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shield_outlined), label: "Modérer"),
            BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined), label: "Missions"),
            BottomNavigationBarItem(
                icon: Icon(Icons.people_outline), label: "Accès"),
          ],
        ),
      ),
    );
  }
}

// --- 1. DASHBOARD STATS (MOBILE FRIENDLY) ---
class AdminStatDashboard extends StatelessWidget {
  const AdminStatDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          "Bonjour, Admin",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Text("État de la ville aujourd'hui",
            style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 25),

        // Cartes en colonne pour mobile
        _buildStatCard(
            "Signalements", "124", Icons.warning_amber_rounded, Colors.orange),
        _buildStatCard("Équipes", "18", Icons.people_outline, Colors.blue),
        _buildStatCard(
            "Zones Clean", "82%", Icons.check_circle_outline, Colors.green),

        const SizedBox(height: 20),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black12),
          ),
          child: const Center(child: Text("Graphique d'activité")),
        )
      ],
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 15),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          Text(value,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}

// --- 2. MODERATION ---
class AdminReportsModeration extends StatelessWidget {
  const AdminReportsModeration({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 5,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: const Icon(Icons.camera_alt, color: Colors.green),
          title: Text("Alerte #20$index"),
          subtitle: const Text("Vérifier le contenu"),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}

// --- 3. MISSIONS ---
class AdminAssignments extends StatelessWidget {
  const AdminAssignments({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text("Assigner des missions"));
}

// --- 4. GESTION ACCÈS ---
class AdminUserManagement extends StatelessWidget {
  const AdminUserManagement({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text("Gérer les utilisateurs"));
}
