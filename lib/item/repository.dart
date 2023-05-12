import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../model/database.dart';
import '../model/entities.dart';

final repositoryProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return Repository(db: db);
});

class Repository {
  Repository({required this.db});

  final Isar db;

  Stream<List<Item>> get stream async* {
    final st = db.items.watchLazy(fireImmediately: true);
    await for (final _ in st) {
      final data = await db.items.where().findAll();
      yield data;
    }
  }

  Future<int> save(Item item) async {
    return db.writeTxn(() => db.items.put(item));
  }

  Future<bool> delete(int id) {
    return db.writeTxn(() => db.items.delete(id));
  }

  Future<Item?> get(int id) async {
    return db.items.get(id);
  }
}
