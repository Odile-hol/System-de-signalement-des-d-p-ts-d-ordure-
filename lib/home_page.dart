import 'package:flutter/material.dart';
import 'login_page.dart';
import 'sing_up_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          // --- FORMES D'ARRIÈRE-PLAN ---
          Positioned(
            top: -100,
            right: -size.width * 0.2,
            child: _buildBackgroundShape(
                size.width * 0.8, const Color(0xFFC8E6C9)),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: _buildBackgroundShape(
                size.width * 0.15, const Color(0xFFDCEDC8)),
          ),

          // --- CONTENU SCROLLABLE ---
          SafeArea(
            child: SingleChildScrollView(
              // <--- AJOUTÉ ICI pour éviter l'overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 25),
                        // --- LOGO ---
                        Row(
                          children: [
                            const Icon(Icons.eco,
                                color: Color(0xFF4CAF50), size: 30),
                            const SizedBox(width: 10),
                            Text(
                              'Cleancity',
                              style: TextStyle(
                                color: Colors.blueGrey[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        // --- TITRE ---
                        const Text(
                          'FUTURE IS\nCLEAN.',
                          style: TextStyle(
                            color: Color(0xFF4CAF50),
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            height: 1.0,
                            letterSpacing: -1.0,
                          ),
                        ),
                        const Text(
                          'APPLICATION',
                          style: TextStyle(
                            color: Color(0xFF263238),
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            height: 1.0,
                            letterSpacing: -1.0,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // --- DESCRIPTION ---
                        const Text(
                          "Réinventons la propreté urbaine grâce à l'intelligence collective.",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 19,
                            height: 1.4,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 35),

                  // --- IMAGE CENTRALE ---
                  Center(
                    child: Container(
                      height: size.height * 0.33,
                      width: size.width * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2E7D32).withOpacity(0.5),
                            blurRadius: 40,
                            spreadRadius: 5,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Image.asset(
                          'assets/home.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                                  child: Icon(Icons.broken_image,
                                      size: 80, color: Colors.grey)),
                        ),
                      ),
                    ),
                  ),

                  // Remplacement du Spacer() par un SizedBox pour le scroll
                  const SizedBox(height: 50),

                  // --- BOUTON ET LIEN ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4CAF50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              elevation: 0,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'SE CONNECTER',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.arrow_forward_rounded,
                                    color: Colors.white, size: 20),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.blueGrey, fontSize: 14),
                                children: [
                                  const TextSpan(
                                      text: "Pas encore de compte ? "),
                                  TextSpan(
                                    text: "Créer un compte",
                                    style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundShape(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
        shape: BoxShape.circle,
      ),
    );
  }
}
