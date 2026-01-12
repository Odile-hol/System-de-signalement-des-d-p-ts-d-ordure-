import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';

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

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          // 1. FOND (Tout en bas)
          Positioned(
            top: -50,
            right: -size.width * 0.2,
            child: _buildBackgroundShape(
                size.width * 0.8, const Color(0xFFE0F2F1)),
          ),

          // 2. LE CONTENU (Milieu)
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                        height:
                            80), // Augmenté pour ne pas chevaucher le logo/bouton
                    const Row(
                      children: [
                        Icon(Icons.eco, color: Color(0xFF4CAF50), size: 28),
                        SizedBox(width: 8),
                        Text('Cleancity',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text('Join Us!',
                        style: TextStyle(
                            color: Color(0xFF4CAF50),
                            fontSize: 38,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text(
                        "Créez votre compte pour transformer votre ville.",
                        style: TextStyle(color: Colors.grey, fontSize: 15)),
                    const SizedBox(height: 30),

                    // --- CHAMPS ---
                    _buildTextFormField(
                        label: 'Nom Complet',
                        icon: Icons.person_outline,
                        validator: (v) =>
                            (v == null || v.isEmpty) ? "Nom requis" : null),
                    const SizedBox(height: 15),
                    _buildTextFormField(
                        label: 'Email',
                        icon: Icons.email_outlined,
                        validator: (v) => (v == null || !v.contains('@'))
                            ? "Email invalide"
                            : null),
                    const SizedBox(height: 15),
                    _buildDropdownField(),

                    if (_selectedRole == 'Admin' ||
                        _selectedRole == 'Equipe de nettoyage') ...[
                      const SizedBox(height: 15),
                      _buildTextFormField(
                        label: 'Code professionnel',
                        icon: Icons.verified_user_outlined,
                        isPassword: true,
                        validator: (v) =>
                            (v == null || v.isEmpty) ? "Code requis" : null,
                      ),
                    ],

                    const SizedBox(height: 15),
                    _buildPasswordField(
                      label: 'Mot de passe',
                      controller: _passController,
                      isObscure: _isPasswordObscure,
                      toggle: () => setState(
                          () => _isPasswordObscure = !_isPasswordObscure),
                    ),
                    const SizedBox(height: 15),
                    _buildPasswordField(
                      label: 'Confirmer mot de passe',
                      controller: _confirmPassController,
                      isObscure: _isConfirmObscure,
                      toggle: () => setState(
                          () => _isConfirmObscure = !_isConfirmObscure),
                      validator: (v) =>
                          (v != _passController.text) ? "Différent" : null,
                    ),
                    const SizedBox(height: 35),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Action signup
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text('SIGN UP',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage())),
                        child: RichText(
                          text: const TextSpan(
                            style:
                                TextStyle(color: Colors.black54, fontSize: 14),
                            children: [
                              TextSpan(text: "Already a member? "),
                              TextSpan(
                                  text: "Login",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),

          // 3. BOUTON RETOUR (Tout en haut - placé à la fin de la liste)
          Positioned(
            top: 45,
            left: 20,
            child: Material(
              // Ajout de Material pour l'effet de clic (splash)
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1), blurRadius: 4)
                    ],
                  ),
                  child: const Icon(Icons.arrow_back_ios_new,
                      color: Color(0xFF4CAF50), size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS DE DÉCORATION (Inchangés mais inclus pour le code complet) ---

  Widget _buildTextFormField(
      {required String label,
      required IconData icon,
      bool isPassword = false,
      String? Function(String?)? validator}) {
    return _fieldDecoration(
      TextFormField(
        obscureText: isPassword,
        validator: validator,
        decoration: InputDecoration(
            hintText: label,
            prefixIcon: Icon(icon, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  Widget _buildPasswordField(
      {required String label,
      required TextEditingController controller,
      required bool isObscure,
      required VoidCallback toggle,
      String? Function(String?)? validator}) {
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
              onPressed: toggle),
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
        decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.assignment_ind_outlined)),
      ),
    );
  }

  Widget _fieldDecoration(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: const Offset(0, 4))
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
            color: color.withOpacity(0.5), shape: BoxShape.circle));
  }
}
