import 'package:flash/model/entities.dart';
import 'package:flash/obra/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

enum ObraSortType {
  lote,
  propietario,
}

final obraSortTypeProvider = StateProvider<ObraSortType>(
  (ref) => ObraSortType.lote,
);

final _obraRepositoryListener = StreamProvider<void>((ref) {
  final stream =
      ref.watch(obraRepository).db.obras.watchLazy(fireImmediately: true);
  return stream;
});

final obrasProvider = StreamProvider((ref) {
  final order = ref.watch(obraSortTypeProvider);
  ref.watch(_obraRepositoryListener);

  return ref.read(obraController).getAll(order: order /*strQuery, kOrder*/);
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

  Stream<List<Obra>> getAll({ObraSortType order = ObraSortType.lote}) async* {
    late final List<Obra> a;
    switch (order) {
      // TODO Implement sortby
      case ObraSortType.lote:
        a = await repository.db.obras.where().findAll();
        break;
      case ObraSortType.propietario:
        a = await repository.db.obras.where().findAll();
        break;
    }
    yield a;
  }
}
