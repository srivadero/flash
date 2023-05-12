import 'package:flash/lote/repository.dart';
import 'package:flash/lote/ui/form.dart';
import 'package:flash/lote/ui/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test lotes list page', (WidgetTester tester) async {
    final repo = LoteRepositoryMock();

    await tester.pumpWidget(ProviderScope(
        overrides: [loteRepository.overrideWithValue(repo)],
        child: const MaterialApp(
          home: LoteListPage(),
        )));

    expect(find.text('Lotes'), findsOneWidget);
    await tester.pumpAndSettle();

    final newBtn = find.byIcon(Icons.add);
    expect(newBtn, findsOneWidget);
    await tester.tap(newBtn);
    await tester.pumpAndSettle();

    expect(find.byType(LoteFormPage), findsOneWidget);
  });
}
