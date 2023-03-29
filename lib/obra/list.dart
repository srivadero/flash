import 'package:flash/model/entities.dart';
import 'package:flash/obra/controller.dart';
import 'package:flash/obra/detail.dart';
import 'package:flash/obra/form.dart';
import 'package:flash/obra/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ObraSortType {
  lote,
  propietario,
}

final obraSortTypeProvider = StateProvider<ObraSortType>(
  // We return the default sort type, here name.
  (ref) => ObraSortType.lote,
);

class ObraListPage extends ConsumerStatefulWidget {
  const ObraListPage({super.key});

  @override
  ConsumerState<ObraListPage> createState() => _ObraListPageState();
}

class _ObraListPageState extends ConsumerState<ObraListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Obras'),
        actions: [
          IconButton(
            onPressed: () async {
              final obra = await showSearch(
                  context: context, delegate: ObraSearchPage());
              if (obra != null && mounted) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ObraDetailPage(obra: obra)));
              }
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () async {
              final value = await Navigator.of(context).push<Obra?>(
                  MaterialPageRoute(
                      builder: (_) => ObraFormPage(obra: Obra())));
              if (value != null) {
                // ref.invalidate(obrasProvider);
              }
            },
            icon: const Icon(Icons.add),
          ),
          PopupMenuButton(
            onSelected: (sortType) {
              ref.read(obraSortTypeProvider.notifier).state = sortType;
              ref.invalidate(obrasProvider);
            },
            itemBuilder: (_) {
              return [
                CheckedPopupMenuItem(
                  checked: ref.watch(obraSortTypeProvider.notifier).state ==
                      ObraSortType.lote,
                  value: ObraSortType.lote,
                  child: const Text('Ordenar por lote'),
                ),
                CheckedPopupMenuItem(
                  checked: ref.watch(obraSortTypeProvider.notifier).state ==
                      ObraSortType.propietario,
                  value: ObraSortType.propietario,
                  child: const Text('Ordenar por propietario'),
                ),
              ];
            },
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: ref.watch(obrasProvider).when(
          data: (List<Obra> data) {
            // sort data
            switch (ref.read(obraSortTypeProvider)) {
              case ObraSortType.lote:
                data.sort((a, b) =>
                    a.lote.value!.nombre.compareTo(b.lote.value!.nombre));
                break;
              case ObraSortType.propietario:
                data.sort((a, b) => a.lote.value!.propietario!
                    .compareTo(b.lote.value!.propietario!));
                break;
            }
            // show data
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final obra = data[index];
                return ListTile(
                  title: Text(
                      '${obra.lote.value?.nombre} - ${obra.lote.value?.propietario}'),
                  subtitle: obra.suspendida
                      ? Text(
                          'Obra suspendida',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        )
                      : Text(obra.avance.nombre),
                  onTap: () async {
                    final result = await Navigator.of(context).push<Obra?>(
                        MaterialPageRoute(
                            builder: (_) => ObraDetailPage(obra: obra)));
                    if (result != null) {
                      // ref.invalidate(obrasProvider);
                    }
                  },
                );
              },
            );
          },
          error: (error, stack) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }
}
