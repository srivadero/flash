import 'package:flash/model/entities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final obraRepository = Provider<ObraRepository>(
    (ref) => ObraRepository(ref.read(databaseProvider)));

final obrasProvider = FutureProvider<List<Obra>>((ref) async {
  return ref.read(obraRepository).getAll();
});

class ObraRepository {
  late final Isar db;

  ObraRepository(this.db);

  Future<int> save(Obra obra) async {
    // obra.lastUpdated = DateTime.now();
    return await db.writeTxnSync(() => db.obras.putSync(obra));
  }

  Future<bool> delete(int id) async {
    return await db.writeTxn(() => db.obras.delete(id));
  }

  Future<Obra?> get(int id) {
    return db.obras.get(id);
  }

  Future<List<Obra>> getAll() {
    return db.obras.where().findAll();
  }
}
