import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/entities.dart';
import 'repository.dart';

final dataProvider = StreamProvider<List<Item>>((ref) {
  final stream = ref.watch(dataCotroller).repository.stream;
  return stream;
});

final dataCotroller = Provider((ref) {
  final repo = ref.watch(repositoryProvider);
  return DataContoller(repository: repo);
});

final itemProvider =
    FutureProvider.autoDispose.family<Item, int?>((ref, id) async {
  if (id == null) return Future.value(Item());
  final item = await ref.watch(dataCotroller).get(id);
  if (item != null) return Future.value(item);
  return Future.error('Not found');
});

class DataContoller {
  late Repository repository;

  DataContoller({required this.repository});

  save(Item item) async {
    repository.save(item);
  }

  delete(int id) {
    repository.delete(id);
  }

  Future<Item?> get(int id) {
    return repository.get(id);
  }
}
