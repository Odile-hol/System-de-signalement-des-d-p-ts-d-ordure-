import 'package:flutter/material.dart';

class CleaningTeamPage extends StatefulWidget {
  const CleaningTeamPage({super.key});

  @override
  State<CleaningTeamPage> createState() => _CleaningTeamPageState();
}

class _CleaningTeamPageState extends State<CleaningTeamPage> {
  int _selectedIndex = 0;

  final List<Widget> _teamViews = [
    const TeamAssignedTasks(),
    const TeamCompletedTasks(),
    const TeamProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "CleanTeam",
          style: TextStyle(
            color: Color(0xFF2E3233),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded,
                color: Colors.grey, size: 22),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded,
                color: Colors.redAccent, size: 22),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _teamViews[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
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
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment_outlined), label: "À faire"),
            BottomNavigationBarItem(
                icon: Icon(Icons.task_alt_outlined), label: "Terminées"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: "Profil"),
          ],
        ),
      ),
    );
  }
}

class TeamAssignedTasks extends StatelessWidget {
  const TeamAssignedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          "Tâches du jour",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Text("Missions urgentes et planifiées",
            style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 20),
        _buildTaskCard(
          context,
          'Dépôt illégal - Melen',
          'Vider les poubelles débordantes.',
          'Urgente',
          Colors.red,
          'https://via.placeholder.com/150/FF5733/FFFFFF?text=Dépôt+Melen',
        ),
        _buildTaskCard(
          context,
          'Nettoyage Zone Marché',
          'Ramassage des ordures.',
          'Planifiée',
          Colors.blue,
          'https://via.placeholder.com/150/3366FF/FFFFFF?text=Marché+Central',
        ),
      ],
    );
  }

  Widget _buildTaskCard(BuildContext context, String title, String description,
      String priority, Color priorityColor, String imageUrl) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    // CORRECTION: Utilisation de withValues() au lieu de withOpacity()
                    color: priorityColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    priority,
                    style: TextStyle(
                        color: priorityColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(description, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                // CORRECTION: Icons.broken_image (en minuscule) et suppression de const
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 120,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey)),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Commencer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TeamCompletedTasks extends StatelessWidget {
  const TeamCompletedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("Historique",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        _buildCompletedTaskTile('Nettoyage du parc', 'Terminée le 15 sept.'),
      ],
    );
  }

  Widget _buildCompletedTaskTile(String title, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 5)
        ],
      ),
      child: ListTile(
        leading: const Icon(Icons.check_circle, color: Colors.green),
        title: Text(title),
        subtitle: Text(date),
      ),
    );
  }
}

class TeamProfile extends StatelessWidget {
  const TeamProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Profil de l'équipe"));
  }
}
