import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../model/database.dart';
import '../model/entities.dart';

final loteRepository = Provider<LoteRepository>(
    (ref) => LoteRepositoryImpl(ref.watch(databaseProvider)));

abstract class LoteRepository {
  Future<int> save(Lote lote);
  Future<bool> delete(int id);
  Future<Lote?> get(int id);
  Future<List<Lote>> getLotes({String? containingText});
  Stream<void> get changeNotifierStream;
}

class LoteRepositoryMock implements LoteRepository {
  @override
  Future<int> save(Lote lote) => Future.value(0);
  @override
  Future<bool> delete(int id) => Future.value(true);
  @override
  Future<Lote?> get(int id) => Future.value(Lote(nombre: 'nombre')..id = id);
  @override
  Stream<void> get changeNotifierStream => Stream.fromFuture(Future.value());

  @override
  Future<List<Lote>> getLotes({String? containingText}) {
    return Future.value([]);
  }
}

class LoteRepositoryImpl implements LoteRepository {
  const LoteRepositoryImpl(this.db);

  final Isar db;

  @override
  Future<int> save(Lote lote) async {
    return await db.writeTxnSync(() => db.lotes.putSync(lote));
  }

  @override
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

  @override
  Future<Lote?> get(int id) {
    return db.lotes.get(id);
  }

  @override
  Stream<void> get changeNotifierStream =>
      db.lotes.watchLazy(fireImmediately: true);

  @override
  Future<List<Lote>> getLotes({String? containingText = ''}) {
    return db.lotes
        .filter()
        .nombreContains(containingText!, caseSensitive: false)
        .or()
        .propietarioContains(containingText, caseSensitive: false)
        .findAll();
  }
}
