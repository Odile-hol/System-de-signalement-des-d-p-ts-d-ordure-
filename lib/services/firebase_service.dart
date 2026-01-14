import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/waste_report.dart';

class FirebaseService {
  static final FirebaseService instance = FirebaseService._internal();
  FirebaseService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Pattern Observer : Flux en temps réel pour la carte et la liste
  Stream<List<WasteReport>> getReports() {
    return _db
        .collection('reports')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => WasteReport.fromFirestore(doc.id, doc.data()))
              .toList(),
        );
  }

  // Envoi complet (Storage + Firestore)
  Future<void> submitReport(
    File img,
    double lat,
    double lng,
    String type,
    String email,
  ) async {
    // 1. Upload vers Cloud Storage
    String path = 'reports/${DateTime.now().millisecondsSinceEpoch}.jpg';
    TaskSnapshot task = await _storage.ref().child(path).putFile(img);
    String url = await task.ref.getDownloadURL();

    // 2. Enregistrement Firestore
    await _db.collection('reports').add({
      'reporterEmail': email,
      'imageUrl': url,
      'lat': lat,
      'lng': lng,
      'type': type,
      'status': 'reported',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Changement d'état (Pattern State)
  Future<void> updateStatus(String id, String newStatus) async {
    await _db.collection('reports').doc(id).update({'status': newStatus});
  }
}
