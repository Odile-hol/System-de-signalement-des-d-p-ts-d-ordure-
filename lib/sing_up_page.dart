import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase obligatoire
import 'login_page.dart';
import 'home_page.dart';
import 'user_session.dart';
import 'citizen_main_page.dart';
import 'admin_page.dart';
import 'cleaning_team_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedRole;
  final List<String> _roles = ['Citoyen', 'Admin', 'Equipe de nettoyage'];

  bool _isPasswordObscure = true;
  bool _isConfirmObscure = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  // --- DIALOGUE ADMIN ---
  void _showAdminPasswordDialog() {
    final TextEditingController adminPassController = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Vérification Admin"),
        content: TextField(
          controller: adminPassController,
          obscureText: true,
          decoration: const InputDecoration(labelText: "Code secret (yaounde)"),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (adminPassController.text == "yaounde") {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminMainPage(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Code incorrect !")),
                );
              }
            },
            child: const Text("VALIDER"),
          ),
        ],
      ),
    );
  }

  // --- DIALOGUE EQUIPE ---
  void _showCleaningTeamPasswordDialog() {
    final TextEditingController teamPassController = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Accès Équipe Terrain"),
        content: TextField(
          controller: teamPassController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: "Code de service (clean)",
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (teamPassController.text == "clean") {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CleaningTeamPage(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Code incorrect !")),
                );
              }
            },
            child: const Text("VALIDER"),
          ),
        ],
      ),
    );
  }

  // --- LOGIQUE D'INSCRIPTION FIREBASE ---
  Future<void> _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        // 1. Création du compte dans Firebase Authentication
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passController.text.trim(),
        );

        // 2. Sauvegarde locale (Session)
        UserSession.instance.saveUser(
          name: _nameController.text,
          mail: _emailController.text,
          userRole: _selectedRole ?? "Citoyen",
        );

        // 3. Redirection selon le rôle
        if (_selectedRole == 'Admin') {
          _showAdminPasswordDialog();
        } else if (_selectedRole == 'Equipe de nettoyage') {
          _showCleaningTeamPasswordDialog();
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CitizenMainPage()),
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMsg = "Erreur d'inscription";
        if (e.code == 'email-already-in-use')
          errorMsg = "Cet email est déjà utilisé.";
        if (e.code == 'weak-password')
          errorMsg = "Le mot de passe est trop court (min 6 caractères).";

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMsg), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -size.width * 0.2,
            child: _buildBackgroundShape(
              size.width * 0.8,
              const Color(0xFFE0F2F1),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    const Row(
                      children: [
                        Icon(Icons.eco, color: Color(0xFF4CAF50)),
                        SizedBox(width: 8),
                        Text(
                          'Cleancity',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Join Us!',
                      style: TextStyle(
                        color: Color(0xFF4CAF50),
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildTextFormField(
                      label: 'Nom Complet',
                      icon: Icons.person_outline,
                      controller: _nameController,
                      validator: (v) =>
                          (v == null || v.isEmpty) ? "Nom requis" : null,
                    ),
                    const SizedBox(height: 15),
                    _buildTextFormField(
                      label: 'Email',
                      icon: Icons.email_outlined,
                      controller: _emailController,
                      validator: (v) => (v == null || !v.contains('@'))
                          ? "Email invalide"
                          : null,
                    ),
                    const SizedBox(height: 15),
                    _buildDropdownField(),
                    const SizedBox(height: 15),
                    _buildPasswordField(
                      label: 'Mot de passe',
                      controller: _passController,
                      isObscure: _isPasswordObscure,
                      toggle: () => setState(
                        () => _isPasswordObscure = !_isPasswordObscure,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildPasswordField(
                      label: 'Confirmer mot de passe',
                      controller: _confirmPassController,
                      isObscure: _isConfirmObscure,
                      toggle: () => setState(
                        () => _isConfirmObscure = !_isConfirmObscure,
                      ),
                      validator: (v) => (v != _passController.text)
                          ? "Les mots de passe ne correspondent pas"
                          : null,
                    ),
                    const SizedBox(height: 35),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _handleSignUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS DE DESIGN (TextFormField, Dropdown, etc.) ---
  Widget _buildTextFormField({
    required String label,
    required IconData icon,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return _fieldDecoration(
      TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: label,
          prefixIcon: Icon(icon, color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool isObscure,
    required VoidCallback toggle,
    String? Function(String?)? validator,
  }) {
    return _fieldDecoration(
      TextFormField(
        controller: controller,
        obscureText: isObscure,
        validator: validator,
        decoration: InputDecoration(
          hintText: label,
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
            onPressed: toggle,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDropdownField() {
    return _fieldDecoration(
      DropdownButtonFormField<String>(
        value: _selectedRole,
        hint: const Text("Choisir votre fonction"),
        items: _roles
            .map((r) => DropdownMenuItem(value: r, child: Text(r)))
            .toList(),
        onChanged: (val) => setState(() => _selectedRole = val),
        validator: (v) => (v == null) ? "Rôle requis" : null,
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.assignment_ind_outlined),
        ),
      ),
    );
  }

  Widget _fieldDecoration(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildBackgroundShape(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
    );
  }
}
