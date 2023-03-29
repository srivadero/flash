import 'package:flash/model/entities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final loteRepository = Provider<LoteRepository>(
    (ref) => LoteRepository(ref.read(databaseProvider)));

// final lotesProvider = FutureProvider.autoDispose<List<Lote>>((ref) async {
//   return ref.read(loteRepository).getAll();
// });

class LoteRepository {
  late final Isar db;

  LoteRepository(this.db);

  Future<int> save(Lote lote) async {
    // log('Lote.save');
    return await db.writeTxnSync(() => db.lotes.putSync(lote));
  }

  Future<bool> delete(int id) async {
    // log('Lote.delete');
    final lote = await db.lotes.get(id);
    await lote!.obras.load();
    return await db.writeTxn(() async {
      for (var obra in lote.obras) {
        await db.obras.delete(obra.id!);
      }
      return db.lotes.delete(id);
    });
  }

  Future<Lote?> get(int id) {
    return db.lotes.get(id);
  }

  // Future<List<Lote>> getAll() {
  //   return db.lotes.where().findAll();
  // }
}
