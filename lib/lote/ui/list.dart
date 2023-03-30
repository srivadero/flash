import 'package:flash/lote/controller.dart';
import 'package:flash/lote/ui/detail.dart';
import 'package:flash/lote/ui/form.dart';
import 'package:flash/lote/ui/search.dart';
import 'package:flash/model/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          _search(context),
          _create(context),
          _sort(context),
        ],
      ),
      body: _list(context),
    );
  }

  Widget _search(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final lote =
            await showSearch(context: context, delegate: LoteSearchPage());
        if (lote != null && mounted) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => LoteDetailPage(lote: lote)));
        }
      },
      icon: const Icon(Icons.search),
    );
  }

  Widget _create(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push<Lote?>(MaterialPageRoute(
            builder: (_) => LoteFormPage(lote: Lote(nombre: ''))));
      },
      icon: const Icon(Icons.add),
    );
  }

  Widget _sort(BuildContext context) {
    return PopupMenuButton(
      onSelected: (sortType) {
        ref.read(loteSortTypeProvider.notifier).state = sortType;
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
    );
  }

  Widget _list(BuildContext context) {
    return ref.watch(lotesProvider).when(
        data: (List<Lote> data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final lote = data[index];
              return ListTile(
                title: Text(lote.nombre),
                subtitle: Text(lote.propietario ?? ''),
                onTap: () {
                  Navigator.of(context).push<Lote?>(MaterialPageRoute(
                      builder: (_) => LoteDetailPage(lote: lote)));
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
            ));
  }
}
