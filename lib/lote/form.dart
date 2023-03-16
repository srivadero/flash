import 'package:flash/lote/repository.dart';
import 'package:flash/model/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoteFormPage extends ConsumerStatefulWidget {
  final Lote lote;
  const LoteFormPage({required this.lote, super.key});

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
      body: SingleChildScrollView(
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await ref.read(loteRepository).save(lote);
                    if (mounted) {
                      Navigator.of(context).pop(lote);
                    }
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
