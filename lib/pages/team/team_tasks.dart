import 'package:flutter/material.dart';
import '../../services/firebase_service.dart';
import '../../models/waste_report.dart';

class TeamTasksPage extends StatelessWidget {
  const TeamTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Interventions en cours"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<WasteReport>>(
        stream: FirebaseService.instance.getReports(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final report = snapshot.data![index];
              return _buildTaskCard(report);
            },
          );
        },
      ),
    );
  }

  Widget _buildTaskCard(WasteReport report) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                report.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report.wasteType,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  _buildStatusChip(report.status),
                ],
              ),
            ),
            _buildActionIcon(report),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color = Colors.grey;
    if (status == 'reported') color = Colors.redAccent;
    if (status == 'inProgress') color = Colors.orange;
    if (status == 'cleaned') color = Colors.green;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionIcon(WasteReport report) {
    if (report.status == 'cleaned')
      return const Icon(Icons.check_circle, color: Colors.green);

    return IconButton(
      icon: Icon(
        report.status == 'reported' ? Icons.play_circle : Icons.stop_circle,
        color: report.status == 'reported' ? Colors.orange : Colors.green,
      ),
      onPressed: () {
        String nextStatus = (report.status == 'reported')
            ? 'inProgress'
            : 'cleaned';
        FirebaseService.instance.updateStatus(report.id, nextStatus);
      },
    );
  }
}
