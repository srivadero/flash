import 'package:flash/lote/repository.dart';
import 'package:flash/model/database.dart';
import 'package:flash/model/entities.dart';
import 'package:flash/obra/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

Future<void> main() async {
  final isar = await IsarDatabase.init(directory: 'Databases', name: 'test.db');

  test('Can add, get and remove a Lote', () async {
    // final isar =
    //     await IsarDatabase.init(directory: 'Databases', name: 'test.db');

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

  test('Can add, get and remove an Obra', () async {
    // final isar =
    //     await IsarDatabase.init(directory: 'Databases', name: 'test.db');

    final container = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(isar)],
    );
    addTearDown(container.dispose);

    final db = container.read(databaseProvider);
    await db.writeTxn(() => db.clear());

    final repo = container.read(obraRepository);
    late Obra? obra;

    // save
    obra = Obra()..lote.value = Lote(nombre: 'LOTE1');
    await repo.save(obra);
    expect(obra.id, 1);

    // read
    obra = await repo.get(1);
    expect(obra, isNotNull);
    expect(obra!.lote.value, isNotNull);

    // delete
    await repo.delete(1);
    obra = await repo.get(1);
    expect(obra, isNull);
  });

  test('Can add, get and remove a lote with obras', () async {
    // final isar =
    //     await IsarDatabase.init(directory: 'Databases', name: 'test.db');

    final container = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(isar)],
    );
    addTearDown(container.dispose);

    final db = container.read(databaseProvider);
    await db.writeTxn(() => db.clear());

    final repo = container.read(loteRepository);
    late Lote? lote;

    // save
    lote = Lote(nombre: '_');
    lote.obras.add(Obra());

    await repo.save(lote);
    expect(lote.id, 1);

    final u = await db.obras.filter().lote((q) => q.idEqualTo(1)).findAll();
    expect(u.length, 1);

    // load
    lote = null;
    lote = await repo.get(1);
    await repo.delete(1);

    final uv = await db.obras.filter().lote((q) => q.idEqualTo(1)).findAll();
    expect(uv.length, 0);
  });
}
