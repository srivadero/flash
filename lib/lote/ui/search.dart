import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/entities.dart';
import '../controller.dart';

class LoteSearchPage extends SearchDelegate<Lote?> {
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
        return ref.watch(_searchProvider(query)).when(
              data: (lotes) {
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
              error: (error, stackTrace) =>
                  Center(child: Text(error.toString())),
              loading: () => const Center(child: CircularProgressIndicator()),
            );
      },
    );
  }

  final _searchProvider = FutureProvider.autoDispose.family<List<Lote>, String>(
      (ref, query) => ref.watch(loteController).getLotes(query: query));
}
