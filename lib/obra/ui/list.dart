import 'package:flash/model/entities.dart';
import 'package:flash/obra/controller.dart';
import 'package:flash/obra/ui/detail.dart';
import 'package:flash/obra/ui/form.dart';
import 'package:flash/obra/ui/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        final obra =
            await showSearch(context: context, delegate: ObraSearchPage());
        if (obra != null && mounted) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => ObraDetailPage(obra: obra)));
        }
      },
      icon: const Icon(Icons.search),
    );
  }

  Widget _create(BuildContext context) {
    return IconButton(
      onPressed: () async {
        Navigator.of(context).push<Obra?>(
            MaterialPageRoute(builder: (_) => ObraFormPage(obra: Obra())));
      },
      icon: const Icon(Icons.add),
    );
  }

  Widget _sort(BuildContext context) {
    return PopupMenuButton(
      onSelected: (sortType) {
        ref.read(obraSortTypeProvider.notifier).state = sortType;
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
    );
  }

  Widget _list(BuildContext context) {
    return ref.watch(obrasProvider).when(
        data: (List<Obra> data) {
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
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      )
                    : Text(obra.avance.nombre),
                onTap: () {
                  Navigator.of(context).push<Obra?>(MaterialPageRoute(
                      builder: (_) => ObraDetailPage(obra: obra)));
                },
              );
            },
          );
        },
        error: (error, stack) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
