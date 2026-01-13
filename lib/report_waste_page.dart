import 'package:flutter/material.dart';

class ReportWastePage extends StatefulWidget {
  const ReportWastePage({super.key});

  @override
  State<ReportWastePage> createState() => _ReportWastePageState();
}

class _ReportWastePageState extends State<ReportWastePage> {
  String? selectedType;
  bool isLocating = false;
  String locationStatus = "Lieu non défini";
  final List<String> types = [
    "Plastique",
    "Gravats",
    "Organique",
    "Électronique",
    "Autre"
  ];

  // Simulation de la géolocalisation
  void _simulateLocation() async {
    setState(() => isLocating = true);
    await Future.delayed(const Duration(seconds: 2)); // Simulation du délai GPS
    setState(() {
      isLocating = false;
      locationStatus = "📍 3.8480° N, 11.5021° E (Yaoundé)";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Signaler un dépôt",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SECTION PHOTO ---
            const Text("Preuve visuelle",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                // Ici on appellerait ImagePicker
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Ouverture de la caméra...")));
              },
              child: Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F8E9),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      color: const Color(0xFF4CAF50).withOpacity(0.5),
                      width: 2,
                      style: BorderStyle.solid),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_a_photo_rounded,
                        size: 60, color: Color(0xFF4CAF50)),
                    const SizedBox(height: 10),
                    Text("Appuyez pour prendre une photo",
                        style: TextStyle(color: Colors.green[800])),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- SECTION GÉOLOCALISATION ---
            const Text("Localisation précise",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on,
                      color: isLocating ? Colors.orange : Colors.red),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                        isLocating ? "Recherche satellite..." : locationStatus,
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w500)),
                  ),
                  TextButton(
                    onPressed: _simulateLocation,
                    child: Text(isLocating ? "" : "ACTUALISER",
                        style: const TextStyle(
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),

            // --- TYPE ET DESCRIPTION ---
            const Text("Détails du dépôt",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildCustomDropdown(),
            const SizedBox(height: 15),
            _buildCustomTextField(
                "Description (ex: Gros volume, odeur forte...)"),

            const SizedBox(height: 40),

            // --- BOUTON DE VALIDATION FINAL ---
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 5,
                  shadowColor: const Color(0xFF4CAF50).withOpacity(0.4),
                ),
                onPressed: () {
                  _showSuccessAnim();
                },
                child: const Text("ENVOYER LE SIGNALEMENT",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS DE STYLE ---
  Widget _buildCustomDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(15)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedType,
          hint: const Text("Sélectionnez le type de déchet"),
          isExpanded: true,
          items: types
              .map((t) => DropdownMenuItem(value: t, child: Text(t)))
              .toList(),
          onChanged: (v) => setState(() => selectedType = v),
        ),
      ),
    );
  }

  Widget _buildCustomTextField(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(15)),
      child: TextField(
        maxLines: 3,
        decoration: InputDecoration(hintText: hint, border: InputBorder.none),
      ),
    );
  }

  void _showSuccessAnim() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 80),
            const SizedBox(height: 20),
            const Text("Transmis avec succès !",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),
            const Text("L'équipe de nettoyage a été notifiée.",
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("RETOUR"),
            )
          ],
        ),
      ),
    );
  }
}
