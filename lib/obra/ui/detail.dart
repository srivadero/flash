import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/entities.dart';
import '../controller.dart';
import 'form.dart';

class ObraDetailPage extends ConsumerStatefulWidget {
  const ObraDetailPage({required this.obra, super.key});

  final Obra obra;

  @override
  ConsumerState<ObraDetailPage> createState() => _ObraDetailPageState();
}

class _ObraDetailPageState extends ConsumerState<ObraDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
        actions: [
          _edit(context),
          _delete(context),
        ],
      ),
      body: _show(context),
    );
  }

  Widget _edit(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final result = await Navigator.of(context).push<Obra?>(
            MaterialPageRoute(builder: (_) => ObraFormPage(obra: widget.obra)));
        if (result != null) {
          setState(() {});
        }
      },
      icon: const Icon(Icons.edit),
    );
  }

  Widget _delete(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final result = await showDialog<bool?>(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Atencion'),
                  content: const Text('Desea eliminar este elemento?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          ref.read(obraController).delete(widget.obra.id!);
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Eliminar')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        autofocus: true,
                        child: const Text('Cancelar')),
                  ],
                ));
        if (mounted && result != null && result == true) {
          Navigator.of(context).pop(widget.obra);
        }
      },
      icon: const Icon(Icons.delete),
    );
  }

  Widget _show(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: const Text('Lote'),
            subtitle: Text(widget.obra.lote.value?.nombre ?? ''),
          ),
          ListTile(
            title: const Text('Propietario'),
            subtitle: Text(widget.obra.lote.value?.propietario ?? ''),
          ),
          ListTile(
            title: const Text('Responsable'),
            subtitle: Text(widget.obra.responsable ?? ''),
          ),
          ListTile(
              title: const Text('Avance'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.obra.avance.nombre),
                  Text(widget.obra.avance.info),
                ],
              )),
          ListTile(
            title: const Text('Estado'),
            subtitle: widget.obra.suspendida
                ? const Text('Obra suspendida',
                    style: TextStyle(color: Colors.red))
                : const Text(
                    'Obra activa',
                    // style: TextStyle(color: Colors.green),
                  ),
          ),
          const SizedBox(
            height: 20,
          ),
          // TextButton(
          //     onPressed: () {
          //       Navigator.of(context).push(
          //           MaterialPageRoute(builder: (_) => const LocationPage()));
          //     },
          //     child: const Text('Ver ubicacion')),
        ],
      ),
    );
  }
}
