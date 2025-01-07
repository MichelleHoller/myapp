// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/main.dart';

void main() {
  testWidgets('Calculadora renderiza corretamente', (WidgetTester tester) async {
    // Constrói o app e dispara o frame.
    await tester.pumpWidget(const App());

    // Verifica se o título "Calculadora" aparece na tela.
    expect(find.text('Calculadora'), findsOneWidget);
    expect(find.text('Erro'), findsNothing);
  });
}
