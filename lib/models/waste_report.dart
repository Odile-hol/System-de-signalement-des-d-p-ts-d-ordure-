import 'package:cloud_firestore/cloud_firestore.dart';

class WasteReport {
  final String id;
  final String reporterEmail;
  final String imageUrl;
  final double lat;
  final double lng;
  final String wasteType;
  final String status; // 'reported', 'inProgress', 'cleaned'
  final DateTime timestamp;

  WasteReport({
    required this.id,
    required this.reporterEmail,
    required this.imageUrl,
    required this.lat,
    required this.lng,
    required this.wasteType,
    required this.status,
    required this.timestamp,
  });

  // Factory pour transformer un document Firestore en objet Dart
  factory WasteReport.fromFirestore(String id, Map<String, dynamic> data) {
    return WasteReport(
      id: id,
      reporterEmail: data['reporterEmail'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      lat: (data['lat'] as num).toDouble(),
      lng: (data['lng'] as num).toDouble(),
      wasteType: data['wasteType'] ?? 'Inconnu',
      status: data['status'] ?? 'reported',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
