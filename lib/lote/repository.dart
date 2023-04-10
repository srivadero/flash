import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../model/database.dart';
import '../model/entities.dart';

final loteRepository = Provider<LoteRepository>(
    (ref) => LoteRepository(ref.watch(databaseProvider)));

class LoteRepository {
  const LoteRepository(this.db);

  final Isar db;

  Future<int> save(Lote lote) async {
    return await db.writeTxnSync(() => db.lotes.putSync(lote));
  }

  Future<bool> delete(int id) async {
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

  Stream<void> get changeNotifierStream =>
      db.lotes.watchLazy(fireImmediately: true);
}
