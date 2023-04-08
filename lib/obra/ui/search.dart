import 'package:flash/model/entities.dart';
import 'package:flash/obra/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ObraSearchPage extends SearchDelegate<Obra?> {
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
        return ref
            .watch(
              _searchProvider(query),
            )
            .when(
              data: (obras) {
                return ListView.builder(
                    itemCount: obras.length,
                    itemBuilder: (context, index) {
                      final obra = obras[index];
                      return ListTile(
                        title: Text(
                            '${obra.lote.value!.propietario} ${obra.lote.value!.nombre}'),
                        onTap: () {
                          close(context, obra);
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

  final _searchProvider = FutureProvider.autoDispose.family<List<Obra>, String>(
      (ref, query) => ref.watch(obraController).getObras(query: query));
}
