import 'package:flash/lote/repository.dart';
import 'package:flash/model/entities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final loteRepositoryListener = StreamProvider<void>((ref) {
  final stream =
      ref.watch(loteRepository).db.lotes.watchLazy(fireImmediately: true);
  return stream;
});

final lotesProvider = StreamProvider((ref) {
  ref.watch(loteRepositoryListener);
  return ref.read(loteController).getAll(/*strQuery, kOrder*/);
});

final loteController =
    Provider<LoteController>((ref) => LoteController(ref.read(loteRepository)));

class LoteController {
  LoteRepository repository;
  LoteController(this.repository);

  Future<int> save(Lote p) async {
    return repository.save(p);
  }

  Future<bool> delete(int id) async {
    return repository.delete(id);
  }

  Future<Lote?> get(int id) async {
    return repository.get(id);
  }

  Stream<List<Lote>> getAll() async* {
    final a = await repository.db.lotes.where().findAll();
    yield a;
  }
}
