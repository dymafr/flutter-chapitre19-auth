import 'package:client/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Le premier écran affiche son texte', (tester) async {
    await tester.pumpWidget(const MyAuth());

    expect(find.text('Dyma'), findsOneWidget);
  });
}
