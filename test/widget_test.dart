import 'package:flutter_test/flutter_test.dart';
import 'package:cleancity/main.dart';

void main() {
  testWidgets('Vérification du chargement de la page',
      (WidgetTester tester) async {
    // On utilise MyApp() qui est définie dans main.dart
    await tester.pumpWidget(const MyApp());

    // Vérifie si le texte 'Cleancity' est présent au démarrage
    expect(find.text('Cleancity'), findsOneWidget);
  });
}
