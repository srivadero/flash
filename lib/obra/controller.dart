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

final astream =
    StreamProvider<void>((ref) => ref.watch(obraController).getDataStream);

final obrasProvider = StreamProvider<List<Obra>>((ref) async* {
  ref.watch(astream);
  final order = ref.watch(obraSortTypeProvider);
  yield await ref.read(obraController).getObras(orderBy: order, query: '');
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

  Stream<void> get getDataStream {
    return repository.changeNotifierStream;
    // await for (final _ in repository.changeNotifierStream) {
    //   yield null;
    // }
  }

  Future<List<Obra>> getObras(
      {ObraSortType orderBy = ObraSortType.lote, String query = ''}) async {
    final result = await repository.db.obras.filter().lote((q) {
      return q
          .nombreContains(query, caseSensitive: false)
          .or()
          .propietarioContains(query, caseSensitive: false);
    }).findAll();

    switch (orderBy) {
      case ObraSortType.lote:
        result.sort(
            (a, b) => a.lote.value!.nombre.compareTo(b.lote.value!.nombre));
        break;
      case ObraSortType.propietario:
        result.sort((a, b) =>
            a.lote.value!.propietario!.compareTo(b.lote.value!.propietario!));
        break;
    }
    return result;
  }
}
