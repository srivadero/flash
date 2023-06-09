import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/entities.dart';
import '../controller.dart';

class LoteFormPage extends ConsumerStatefulWidget {
  const LoteFormPage({required this.lote, super.key});

  final Lote lote;

  @override
  ConsumerState<LoteFormPage> createState() => _LoteFormPageState();
}

class _LoteFormPageState extends ConsumerState<LoteFormPage> {
  final _formKey = GlobalKey<FormState>();
  late Lote lote;

  @override
  void initState() {
    super.initState();
    lote = widget.lote;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (lote.id != null)
            ? const Text('Edicion')
            : const Text('Nuevo lote'),
      ),
      body: _form(context),
    );
  }

  Widget _form(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: lote.nombre,
              textCapitalization: TextCapitalization.characters,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Lote'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'No debe estar vacio';
                }
                return null;
              },
              onSaved: (newValue) {
                lote.nombre = newValue!;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: lote.propietario,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(labelText: 'Propietario'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'No debe estar vacio';
                }
                return null;
              },
              onSaved: (newValue) {
                lote.propietario = newValue!;
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ref.read(loteController).save(lote);
                  Navigator.of(context).pop(lote);
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
