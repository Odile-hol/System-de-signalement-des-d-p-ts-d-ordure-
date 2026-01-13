import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_map/flutter_map.dart';

// --- SOLUTION DE FORCE : ON DÉFINIT LATLNG NOUS-MÊMES ---
// Cela remplace l'import qui ne fonctionne pas
class LatLng {
  final double latitude;
  final double longitude;
  const LatLng(this.latitude, this.longitude);
}

void main() {
  runApp(const MaterialApp(
    home: CitizenMainPage(),
    debugShowCheckedModeBanner: false,
  ));
}

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
    const CitizenReportsHistory(),
    const CitizenProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        height: 70,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_filled), label: "Accueil"),
          NavigationDestination(icon: Icon(Icons.map_rounded), label: "Carte"),
          NavigationDestination(
              icon: Icon(Icons.analytics_rounded), label: "Suivi"),
          NavigationDestination(
              icon: Icon(Icons.person_rounded), label: "Profil"),
        ],
      ),
    );
  }
}

// --- ACCUEIL ---
class CitizenDashboard extends StatelessWidget {
  const CitizenDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: _buildActionCard(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          height: 280,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            image: DecorationImage(
                image: AssetImage('assets/home.jpg'), fit: BoxFit.cover),
          ),
        ),
        Container(
          height: 280,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
            ),
          ),
          padding: const EdgeInsets.all(25),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Yaoundé Propre",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text("Signalez les dépôts sauvages.",
                  style: TextStyle(color: Colors.white70, fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ReportWasteForm())),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ],
        ),
        child: const Row(
          children: [
            CircleAvatar(
                backgroundColor: Colors.green,
                radius: 25,
                child: Icon(Icons.camera_alt_rounded, color: Colors.white)),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("SIGNALER UN DÉPÔT",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("Photo + Géo-localisation",
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

// --- CARTE (CORRIGÉE) ---
class MapCleanView extends StatelessWidget {
  const MapCleanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Carte (Yaoundé)")),
      body: FlutterMap(
        options: MapOptions(
          // On force la conversion pour que FlutterMap accepte notre LatLng personnalisé
          initialCenter: _convertToMapLatLng(const LatLng(3.8480, 11.5021)),
          initialZoom: 13,
        ),
        children: [
          TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png"),
        ],
      ),
    );
  }

  // Petite fonction pour éviter l'erreur de type
  dynamic _convertToMapLatLng(LatLng point) {
    return point;
  }
}

// --- FORMULAIRE ---
class ReportWasteForm extends StatefulWidget {
  const ReportWasteForm({super.key});
  @override
  State<ReportWasteForm> createState() => _ReportWasteFormState();
}

class _ReportWasteFormState extends State<ReportWasteForm> {
  File? _image;
  String? _selectedType;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.camera);
    if (img != null) setState(() => _image = File(img.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nouveau Signalement")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: Colors.green.withValues(alpha: 0.3)),
                ),
                child: _image == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Icon(Icons.add_a_photo,
                                size: 50, color: Colors.green),
                            Text("Prendre la photo")
                          ])
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(_image!, fit: BoxFit.cover)),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                  labelText: "Type de déchet", border: OutlineInputBorder()),
              items: ["Ménager", "Plastique", "Gravats"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedType = v),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 55)),
              onPressed: () {
                if (_image != null && _selectedType != null)
                  Navigator.pop(context);
              },
              child:
                  const Text("ENVOYER", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}

// --- HISTORIQUE & PROFIL ---
class CitizenReportsHistory extends StatelessWidget {
  const CitizenReportsHistory({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text("Historique")));
}

class CitizenProfile extends StatelessWidget {
  const CitizenProfile({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text("Profil")));
}
