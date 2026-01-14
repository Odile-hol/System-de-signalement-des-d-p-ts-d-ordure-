import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Assurez-vous d'avoir latlong2 dans pubspec.yaml
import '../../services/firebase_service.dart';
import '../../models/waste_report.dart';

class MapCleanView extends StatelessWidget {
  const MapCleanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Carte Yaoundé Propre")),
      body: StreamBuilder<List<WasteReport>>(
        stream: FirebaseService.instance.getReports(),
        builder: (context, snapshot) {
          List<Marker> markers = [];
          if (snapshot.hasData) {
            markers = snapshot.data!.map((report) {
              return Marker(
                point: LatLng(report.lat, report.lng),
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              );
            }).toList();
          }

          return FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(3.8480, 11.5021),
              initialZoom: 13,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              MarkerLayer(markers: markers),
            ],
          );
        },
      ),
    );
  }
}
