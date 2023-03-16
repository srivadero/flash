import 'package:flash/lote/detail.dart';
import 'package:flash/lote/form.dart';
import 'package:flash/lote/repository.dart';
import 'package:flash/lote/search.dart';
import 'package:flash/model/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LoteSortType {
  nombre,
  propietario,
}

final loteSortTypeProvider = StateProvider<LoteSortType>(
  // We return the default sort type, here name.
  (ref) => LoteSortType.nombre,
);

class LoteListPage extends ConsumerStatefulWidget {
  const LoteListPage({super.key});

  @override
  ConsumerState<LoteListPage> createState() => _LoteListPageState();
}

class _LoteListPageState extends ConsumerState<LoteListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lotes'),
        actions: [
          IconButton(
            onPressed: () async {
              final lote = await showSearch(
                  context: context, delegate: LoteSearchPage());
              if (lote != null && mounted) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => LoteDetailPage(lote: lote)));
              }
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () async {
              final result = await Navigator.of(context).push<Lote?>(
                  MaterialPageRoute(
                      builder: (_) => LoteFormPage(lote: Lote(nombre: ''))));
              if (result != null) {
                ref.invalidate(lotesProvider);
              }
            },
            icon: const Icon(Icons.add),
          ),
          PopupMenuButton(
            onSelected: (sortType) {
              ref.read(loteSortTypeProvider.notifier).state = sortType;
              ref.invalidate(lotesProvider);
            },
            itemBuilder: (_) {
              return [
                CheckedPopupMenuItem(
                  checked: ref.watch(loteSortTypeProvider.notifier).state ==
                      LoteSortType.nombre,
                  value: LoteSortType.nombre,
                  child: const Text('Ordenar por lote'),
                ),
                CheckedPopupMenuItem(
                  checked: ref.watch(loteSortTypeProvider.notifier).state ==
                      LoteSortType.propietario,
                  value: LoteSortType.propietario,
                  child: const Text('Ordenar por propietario'),
                ),
              ];
            },
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: ref.watch(lotesProvider).when(
          data: (List<Lote> data) {
            // sort data
            switch (ref.read(loteSortTypeProvider)) {
              case LoteSortType.nombre:
                data.sort((a, b) =>
                    a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase()));
                break;
              case LoteSortType.propietario:
                data.sort((a, b) => a.propietario!.compareTo(b.propietario!));
                break;
            }
            // show data
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final lote = data[index];
                return ListTile(
                  title: Text(lote.nombre),
                  subtitle: Text(lote.propietario ?? ''),
                  onTap: () async {
                    final result = await Navigator.of(context).push<Lote?>(
                        MaterialPageRoute(
                            builder: (_) => LoteDetailPage(lote: lote)));
                    if (result != null) {
                      ref.invalidate(lotesProvider);
                    }
                  },
                );
              },
            );
          },
          error: (Object error, StackTrace stackTrace) => Center(
                child: Text(error.toString()),
              ),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
