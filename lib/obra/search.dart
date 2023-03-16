import 'package:flash/model/entities.dart';
import 'package:flash/obra/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class ObraSearchPage extends SearchDelegate<Obra?> {
  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   final theme = Theme.of(context);
  //   return theme;
  // }

  ObraSearchPage() : super(searchFieldLabel: 'Buscar');

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
        final obras = ref.watch(obraRepository).db.obras.filter().lote((q) {
          return q
              .propietarioContains(query, caseSensitive: false)
              .or()
              .nombreContains(query, caseSensitive: false);
        }).findAllSync();
        return ListView.builder(
            itemCount: obras.length,
            itemBuilder: (context, index) {
              final obra = obras[index];
              return ListTile(
                title: Text(
                    '${obra.lote.value?.nombre} ${obra.lote.value?.propietario ?? ''}'),
                onTap: () {
                  close(context, obra);
                },
              );
            });
      },
    );
  }
}
