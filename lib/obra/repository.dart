import 'package:flash/model/database_provider.dart';
import 'package:flash/model/entities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final obraRepository = Provider<ObraRepository>((ref) {
  return ObraRepository(ref.watch(databaseProvider));
});

class ObraRepository {
  late final Isar db;

  ObraRepository(this.db);

  Future<int> save(Obra obra) async {
    if (obra.lote.value == null) {
      throw Exception('property lote must not be null in Obra');
    }
    // obra.lastUpdated = DateTime.now();
    return await db.writeTxnSync(() => db.obras.putSync(obra));
  }

  Future<bool> delete(int id) async {
    return await db.writeTxn(() => db.obras.delete(id));
  }

  Future<Obra?> get(int id) {
    return db.obras.get(id);
  }

  Stream<void> get changeNotifierStream async* {
    final dbstream = db.obras.watchLazy(fireImmediately: true);
    await for (final _ in dbstream) {
      yield null;
    }
  }
}
