import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../model/database.dart';
import '../model/entities.dart';

final obraRepository = Provider<ObraRepository>(
    (ref) => ObraRepository(ref.watch(databaseProvider)));

class ObraRepository {
  const ObraRepository(this.db);

  final Isar db;

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

  Stream<void> get changeNotifierStream =>
      db.obras.watchLazy(fireImmediately: true);
}
