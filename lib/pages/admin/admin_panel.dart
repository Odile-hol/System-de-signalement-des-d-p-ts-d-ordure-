import 'package:flutter/material.dart';
import '../../services/firebase_service.dart';
import '../../models/waste_report.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Console Admin - Yaoundé"),
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<WasteReport>>(
        stream: FirebaseService.instance.getReports(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          final reports = snapshot.data!;
          int cleaningCount = reports
              .where((r) => r.status == 'cleaned')
              .length;

          return Column(
            children: [
              _buildStatsHeader(reports.length, cleaningCount),
              Expanded(
                child: ListView.builder(
                  itemCount: reports.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(reports[index].imageUrl),
                    ),
                    title: Text(reports[index].wasteType),
                    subtitle: Text(
                      "Signalé par : ${reports[index].reporterEmail}",
                    ),
                    trailing: Icon(
                      Icons.circle,
                      color: _getStatusColor(reports[index].status),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatsHeader(int total, int cleaned) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.green[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem("Total", total.toString(), Colors.black),
          _statItem("Traités", cleaned.toString(), Colors.green),
          _statItem("En attente", (total - cleaned).toString(), Colors.orange),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Color _getStatusColor(String status) {
    if (status == 'cleaned') return Colors.green;
    if (status == 'inProgress') return Colors.orange;
    return Colors.red;
  }
}
