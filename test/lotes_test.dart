import 'package:flash/lote/repository.dart';
import 'package:flash/model/entities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

Future<void> main() async {
  test('Can add, get and remove a Lote', () async {
    final isar = await Isar.open([LoteSchema, ObraSchema], name: 'test-db');

    final container = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(isar)],
    );
    addTearDown(container.dispose);

    final db = container.read(databaseProvider);
    await db.writeTxn(() => db.clear());

    final repo = container.read(loteRepository);
    late Lote? lote;

    // save
    lote = Lote(nombre: 'nombre_1');
    await repo.save(lote);
    expect(lote.id, 1);

    // read
    lote = await repo.get(1);
    expect(lote, isNotNull);
    expect(lote!.nombre.length, greaterThan(0));

    // delete
    await repo.delete(1);
    lote = await repo.get(1);
    expect(lote, isNull);
  });
}
