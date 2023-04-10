import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../lote/controller.dart';
import '../../model/entities.dart';
import '../controller.dart';

class ObraFormPage extends ConsumerStatefulWidget {
  const ObraFormPage({required this.obra, super.key});

  final Obra obra;

  @override
  ConsumerState<ObraFormPage> createState() => _ObraFormPageState();
}

class _ObraFormPageState extends ConsumerState<ObraFormPage> {
  final _formKey = GlobalKey<FormState>();
  late Obra obra;

  @override
  void initState() {
    super.initState();
    obra = widget.obra;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (obra.id != null)
            ? const Text('Edicion')
            : const Text('Nueva obra'),
      ),
      body: _form(context),
    );
  }

  final _searchProvider = FutureProvider.autoDispose.family<List<Lote>, String>(
      (ref, query) => ref.watch(loteController).getLotes(query: query));

  Widget _form(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ref.watch(_searchProvider('')).when(
                data: (List<Lote> data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      DropdownSearch<Lote>(
                        popupProps: const PopupProps.menu(
                            showSearchBox: true,
                            searchDelay: Duration(milliseconds: 100)),
                        selectedItem: obra.lote.value,
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration:
                                InputDecoration(labelText: 'Lote')),
                        validator: (lote) {
                          if (lote == null) return 'Debe seleccionar lote';
                          return null;
                        },
                        onSaved: (lote) {
                          obra.lote.value = lote;
                        },
                        itemAsString: (item) =>
                            '${item.nombre} - ${item.propietario}',
                        items: data,
                      ),
                    ],
                  );
                },
                error: (Object error, StackTrace stackTrace) =>
                    Text(error.toString()),
                loading: () => const CircularProgressIndicator()),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: obra.responsable,
              textCapitalization: TextCapitalization.characters,
              decoration:
                  const InputDecoration(labelText: 'Responsable de obra'),
              onSaved: (newValue) {
                obra.responsable = newValue!;
              },
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownSearch<AvanceObra>(
                  selectedItem: obra.avance,
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration:
                          InputDecoration(labelText: 'Avance de obra')),
                  validator: (lote) {
                    if (lote == null) return 'Debe seleccionar';
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      obra.avance = value!;
                    });
                  },
                  onSaved: (value) {
                    obra.avance = value!;
                  },
                  itemAsString: (item) => item.nombre,
                  items: AvanceObra.values,
                ),
                const SizedBox(height: 10),
                Text(
                  obra.avance.info,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 10),
            SwitchListTile(
                title: const Text('Obra suspendida'),
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                value: obra.suspendida,
                onChanged: (value) {
                  setState(() {
                    obra.suspendida = value;
                  });
                }),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ref.read(obraController).save(obra);
                  ref.read(loteController).save(obra.lote.value!);
                  Navigator.of(context).pop(obra);
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
