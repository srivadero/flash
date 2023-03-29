import 'package:flash/lote/form.dart';
import 'package:flash/lote/repository.dart';
import 'package:flash/model/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoteDetailPage extends ConsumerStatefulWidget {
  final Lote lote;
  const LoteDetailPage({required this.lote, super.key});

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
          IconButton(
            onPressed: () async {
              final result = await Navigator.of(context).push<Lote?>(
                  MaterialPageRoute(
                      builder: (_) => LoteFormPage(lote: widget.lote)));
              if (result != null) {
                // ref.invalidate(lotesProvider);
                setState(() {});
              }
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              final result = await showDialog<bool?>(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Atencion'),
                        content: const Text('Desea eliminar este elemento?'),
                        actions: [
                          TextButton(
                              onPressed: () {
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
              if (result != null && result == true) {
                await ref.read(loteRepository).delete(widget.lote.id!);
                // ref.invalidate(lotesProvider);
                if (mounted) {
                  Navigator.of(context).pop(widget.lote);
                }
              }
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
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
            // const SizedBox(height: 20),
            ListTile(
              title: const Text('Obras'),
              subtitle: widget.lote.obras.isEmpty
                  ? const Text('No tiene')
                  : Text(widget.lote.obras.length.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
