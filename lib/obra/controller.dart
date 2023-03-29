import 'package:flash/model/entities.dart';
import 'package:flash/obra/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final obraRepositoryListener = StreamProvider<void>((ref) {
  final stream =
      ref.watch(obraRepository).db.obras.watchLazy(fireImmediately: true);
  return stream;
});

final obrasProvider = StreamProvider((ref) {
  ref.watch(obraRepositoryListener);
  return ref.read(obraController).getAll(/*strQuery, kOrder*/);
});

final obraController =
    Provider<ObraController>((ref) => ObraController(ref.read(obraRepository)));

class ObraController {
  ObraRepository repository;
  ObraController(this.repository);

  Future<int> save(Obra p) async {
    return repository.save(p);
  }

  Future<bool> delete(int id) async {
    return repository.delete(id);
  }

  Future<Obra?> get(int id) async {
    return repository.get(id);
  }

  Stream<List<Obra>> getAll() async* {
    final a = await repository.db.obras.where().findAll();
    yield a;
  }
}
