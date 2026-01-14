class UserSession {
  // Instance unique (Singleton)
  static final UserSession instance = UserSession._internal();
  UserSession._internal();

  String? userName;
  String? userMail;
  String? userRole;

  // Méthode pour sauvegarder les infos après connexion ou inscription
  void saveUser({
    required String name,
    required String mail,
    required String role,
  }) {
    userName = name;
    userMail = mail;
    userRole = role;
  }

  // Méthode pour vider la session (Déconnexion)
  void clear() {
    userName = null;
    userMail = null;
    userRole = null;
  }
}
