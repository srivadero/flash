import 'package:flash/model/entities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final loteRepository = Provider<LoteRepository>(
    (ref) => LoteRepository(ref.read(databaseProvider)));

final lotesProvider = FutureProvider<List<Lote>>((ref) async {
  return ref.read(loteRepository).getAll();
});

class LoteRepository {
  late final Isar db;

  LoteRepository(this.db);

  Future<int> save(Lote lote) async {
    return await db.writeTxnSync(() => db.lotes.putSync(lote));
  }

  Future<bool> delete(int id) async {
    // TODO Ver si deletesync borra las obras tambien
    // print('Deleting lote: ${id}');
    // final lote = await db.lotes.get(id);
    // await lote!.obras.load();
    // print('Obras: ${lote.obras.length}');

    return await db.writeTxn(() {
      // lote.obras.forEach((obra) async {
      //   print('Deleting obra: ${obra.id}');
      //   await db.obras.delete(obra.id!);
      // });
      // return Future.value(false);
      return db.lotes.delete(id);
    });
  }

  Future<Lote?> get(int id) {
    return db.lotes.get(id);
  }

  Future<List<Lote>> getAll() {
    return db.lotes.where().findAll();
  }
}
