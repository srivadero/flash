import 'dart:developer';

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

final _loteRepositoryListener = StreamProvider<void>((ref) {
  final stream =
      ref.watch(loteRepository).db.lotes.watchLazy(fireImmediately: true);
  return stream;
});

final lotesProvider = StreamProvider((ref) {
  final order = ref.watch(loteSortTypeProvider);
  log('Order by: ${order.name}');
  ref.watch(_loteRepositoryListener);
  return ref.read(loteController).getAll(order: order /*strQuery*/);
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

  Stream<List<Lote>> getAll({LoteSortType order = LoteSortType.nombre}) async* {
    late final List<Lote> a;
    switch (order) {
      case LoteSortType.nombre:
        a = await repository.db.lotes.where().sortByNombre().findAll();
        break;
      case LoteSortType.propietario:
        a = await repository.db.lotes.where().sortByPropietario().findAll();
        break;
    }
    yield a;
  }
}
