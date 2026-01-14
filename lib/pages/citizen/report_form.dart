import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../services/firebase_service.dart';
import '../../core/user_session.dart';

// Vérifiez bien ce nom de classe, c'est lui qui est appelé par le Dashboard
class ReportWasteForm extends StatefulWidget {
  const ReportWasteForm({super.key});

  @override
  State<ReportWasteForm> createState() => _ReportWasteFormState();
}

class _ReportWasteFormState extends State<ReportWasteForm> {
  File? _image;
  String? _selectedType;
  bool _isUploading = false;
  final List<String> _wasteTypes = [
    "Ménager",
    "Plastique",
    "Électronique",
    "Gravats",
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> _submitReport() async {
    if (_image == null || _selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez ajouter une photo et un type")),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      // Appel au service Firebase (BaaS)
      await FirebaseService.instance.submitReport(
        _image!,
        3.8480, // Latitude Yaoundé fictive
        11.5021, // Longitude Yaoundé fictive
        _selectedType!,
        UserSession.instance.userMail ?? "anonyme@cleancity.cm",
      );

      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Signalement envoyé avec succès !"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erreur : $e")));
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signaler un déchet")),
      body: _isUploading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green, width: 2),
                      ),
                      child: _image == null
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  size: 60,
                                  color: Colors.green,
                                ),
                                Text(
                                  "Prendre une photo",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.file(_image!, fit: BoxFit.cover),
                            ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Type de déchet",
                      border: OutlineInputBorder(),
                    ),
                    items: _wasteTypes
                        .map(
                          (type) =>
                              DropdownMenuItem(value: type, child: Text(type)),
                        )
                        .toList(),
                    onChanged: (val) => setState(() => _selectedType = val),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _submitReport,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "ENVOYER AU SERVICE DE NETTOYAGE",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
