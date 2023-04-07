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

final obrasProvider = StreamProvider<List<Obra>>((ref) {
  final order = ref.watch(obraSortTypeProvider);
  return ref.read(obraController).getData(sortBy: order /*strQuery, kOrder*/);
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

  Stream<List<Obra>> getData({ObraSortType sortBy = ObraSortType.lote}) async* {
    await for (final _ in repository.changeNotifierStream) {
      switch (sortBy) {
        case ObraSortType.propietario:
          yield await getByPropietario();
          break;
        case ObraSortType.lote:
          yield await getByLote();
          break;
      }
    }
  }

  Future<List<Obra>> getByPropietario() async {
    return repository.db.obras
        .where()
        // TODO .sortByPropietario()
        // .filter()
        // .lote((q){
        //   return q.propietarioContains('').or().nombreContains('');
        // })
        .findAll();
  }

  Future<List<Obra>> getByLote() async {
    return repository.db.obras
        .where()
        // TODO .sortByNombre()
        .findAll();
  }
}
