import 'package:flash/lote/repository.dart';
import 'package:flash/lote/ui/form.dart';
import 'package:flash/model/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('form smoke test', (tester) async {});

  testWidgets('Show form page', (tester) async {
    // GIVEN app is running
    final repo = LoteRepositoryMock();

    await tester.pumpWidget(ProviderScope(
        overrides: [loteRepository.overrideWithValue(repo)],
        child: MaterialApp(
          home: LoteFormPage(lote: Lote(nombre: '')),
        )));

    // THEN I see
    //
    expect(find.byType(LoteFormPage), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Lote'), findsOneWidget);
    expect(find.text('Propietario'), findsOneWidget);
    expect(find.text('Guardar'), findsOneWidget);
  });

  testWidgets('Submit with invalid data', (tester) async {
    // GIVEN App is running
    final repo = LoteRepositoryMock();

    await tester.pumpWidget(ProviderScope(
        overrides: [loteRepository.overrideWithValue(repo)],
        child: MaterialApp(
          home: LoteFormPage(lote: Lote(nombre: '')),
        )));

    // WHEN
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // THEN
    expect(find.byType(LoteFormPage), findsOneWidget);
  });

  testWidgets('Submit with valid data', (tester) async {
    // GIVEN App is running
    final repo = LoteRepositoryMock();

    await tester.pumpWidget(ProviderScope(
        overrides: [loteRepository.overrideWithValue(repo)],
        child: MaterialApp(
          home: LoteFormPage(lote: Lote(nombre: '')),
        )));

    // WHEN
    await tester.enterText(find.byType(TextFormField).at(0), 'test_data');
    await tester.enterText(find.byType(TextFormField).at(1), 'test_data');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // THEN
    expect(find.byType(LoteFormPage), findsNothing);
  });
}
