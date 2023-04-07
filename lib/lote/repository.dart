import 'package:flash/model/database_provider.dart';
import 'package:flash/model/entities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final loteRepository = Provider<LoteRepository>(
    (ref) => LoteRepository(ref.watch(databaseProvider)));

class LoteRepository {
  late final Isar db;

  LoteRepository(this.db);

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

  Stream<void> get changeNotifierStream async* {
    final dbstream = db.lotes.watchLazy(fireImmediately: true);
    await for (final _ in dbstream) {
      yield null;
    }
  }
}
