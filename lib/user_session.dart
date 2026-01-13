class UserSession {
  static final UserSession instance = UserSession._internal();
  UserSession._internal();

  String? userName;
  String? userMail; // <--- Vérifie que cette ligne est bien présente
  String? userRole;

  void saveUser(
      {required String name, required String mail, required String userRole}) {
    this.userName = name;
    this.userMail = mail; // <--- Et celle-ci aussi
    this.userRole = userRole;
  }
}
