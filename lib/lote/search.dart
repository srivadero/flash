import 'package:flash/lote/repository.dart';
import 'package:flash/model/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class LoteSearchPage extends SearchDelegate<Lote?> {
  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   final theme = Theme.of(context);
  //   return theme;
  // }

  LoteSearchPage() : super(searchFieldLabel: 'Buscar');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query.isEmpty ? close(context, null) : query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return getData();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return getData();
  }

  Widget getData() {
    if (query.isEmpty) return Container();
    return Consumer(
      builder: (context, ref, child) {
        final lotes = ref
            .watch(loteRepository)
            .db
            .lotes
            .filter()
            .nombreContains(query, caseSensitive: false)
            .or()
            .propietarioContains(query, caseSensitive: false)
            .findAllSync();
        return ListView.builder(
            itemCount: lotes.length,
            itemBuilder: (context, index) {
              final lote = lotes[index];
              return ListTile(
                title: Text('${lote.nombre} ${lote.propietario}'),
                onTap: () {
                  close(context, lote);
                },
              );
            });
      },
    );
  }
}
