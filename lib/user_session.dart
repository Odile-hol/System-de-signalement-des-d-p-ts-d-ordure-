class UserSession {
  // Instance unique
  static final UserSession _instance = UserSession._internal();

  // Données de l'utilisateur
  String? userName;
  String? email;
  String? role;
  bool isConnected = false;

  UserSession._internal();

  // Accesseur
  static UserSession get instance => _instance;

  // Méthode de sauvegarde
  void saveUser(
      {required String name, required String mail, required String userRole}) {
    userName = name;
    email = mail;
    role = userRole;
    isConnected = true;
  }
}
