import 'package:flash/lote/repository.dart';
import 'package:flash/model/entities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

enum LoteSortType {
  nombre,
  propietario,
}

final loteSortTypeProvider = StateProvider<LoteSortType>((ref) {
  return LoteSortType.nombre;
});

final lotesProvider = StreamProvider<List<Lote>>((ref) {
  final order = ref.watch(loteSortTypeProvider);
  return ref.read(loteController).getData(sortBy: order /*strQuery*/);
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

  Stream<List<Lote>> getData(
      {LoteSortType sortBy = LoteSortType.nombre}) async* {
    await for (final _ in repository.changeNotifierStream) {
      switch (sortBy) {
        case LoteSortType.propietario:
          yield await getByPropietario();
          break;
        case LoteSortType.nombre:
          yield await getByName();
          break;
      }
    }
  }

  Future<List<Lote>> getByPropietario() async {
    return repository.db.lotes.where().sortByPropietario().findAll();
  }

  Future<List<Lote>> getByName() async {
    return repository.db.lotes.where().sortByNombre().findAll();
  }
}
