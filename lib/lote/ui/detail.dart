import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/entities.dart';
import '../controller.dart';
import 'form.dart';

class LoteDetailPage extends ConsumerStatefulWidget {
  const LoteDetailPage({required this.lote, super.key});

  final Lote lote;

  @override
  ConsumerState<LoteDetailPage> createState() => _LoteDetailPageState();
}

class _LoteDetailPageState extends ConsumerState<LoteDetailPage> {
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
        body: _show(context));
  }

  Widget _edit(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final result = await Navigator.of(context).push<Lote?>(
            MaterialPageRoute(builder: (_) => LoteFormPage(lote: widget.lote)));
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
                          ref.read(loteController).delete(widget.lote.id!);
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
          Navigator.of(context).pop(widget.lote);
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
            subtitle: Text(widget.lote.nombre),
          ),
          ListTile(
            title: const Text('Propietario'),
            subtitle: Text(widget.lote.propietario ?? ''),
          ),
          ListTile(
            title: const Text('Obras'),
            subtitle: widget.lote.obras.isEmpty
                ? const Text('No tiene')
                : Text(widget.lote.obras.length.toString()),
          ),
        ],
      ),
    );
  }
}
