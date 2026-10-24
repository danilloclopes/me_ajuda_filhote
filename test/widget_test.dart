import 'package:flutter_test/flutter_test.dart';

import 'package:me_ajuda_filhote/main.dart';

void main() {
  testWidgets('Tela inicial mostra pesquisa, tutorial e todos os cards',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MeAjudaFilhoteApp());

    expect(find.text('Pesquise aqui'), findsOneWidget);
    expect(find.text('TUTORIAL DO MAF'), findsOneWidget);
    for (final titulo in [
      'WHATSAPP',
      'UBER',
      'YOUTUBE',
      'IFOOD',
      'HISTÓRICO',
      'FAVORITOS',
    ]) {
      expect(find.text(titulo), findsOneWidget);
    }
  });
}
