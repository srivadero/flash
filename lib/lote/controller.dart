import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:isar/isar.dart';

import '../model/entities.dart';
import 'repository.dart';

enum LoteSortType {
  nombre,
  propietario,
}

final loteSortTypeProvider =
    StateProvider<LoteSortType>((ref) => LoteSortType.nombre);

final lotesStream =
    StreamProvider<void>((ref) => ref.watch(loteController).getDataStream);

final lotesProvider = StreamProvider<List<Lote>>((ref) async* {
  ref.watch(lotesStream);
  final order = ref.watch(loteSortTypeProvider);
  yield await ref.read(loteController).getLotes(orderBy: order, query: '');
});

final loteController = Provider<LoteController>(
    (ref) => LoteController(ref.watch(loteRepository)));

class LoteController {
  const LoteController(this.repository);

  final LoteRepository repository;

  Future<int> save(Lote p) async {
    return repository.save(p);
  }

  Future<bool> delete(int id) async {
    return repository.delete(id);
  }

  Future<Lote?> get(int id) async {
    return repository.get(id);
  }

  Stream<void> get getDataStream {
    return repository.changeNotifierStream;
  }

  Future<List<Lote>> getLotes(
      {LoteSortType orderBy = LoteSortType.nombre, String query = ''}) async {
    final result = await repository.getLotes(containingText: query);
    // final result = await repository.db.lotes
    //     .filter()
    //     .nombreContains(query, caseSensitive: false)
    //     .or()
    //     .propietarioContains(query, caseSensitive: false)
    //     .findAll();

    switch (orderBy) {
      case LoteSortType.nombre:
        result.sort((a, b) => a.nombre.compareTo(b.nombre));
        break;
      case LoteSortType.propietario:
        result.sort((a, b) => a.propietario!.compareTo(b.propietario!));
        break;
    }
    return result;
  }
}
