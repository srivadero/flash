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

  Widget _form(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // TODO Usar loteController.getLotes en lugar de lotesProvider para sacar dependencia
            // Ver forma deimpkementar como en lote/search usando un provider
            ref.watch(lotesProvider).when(
                data: (List<Lote> data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // TextButton(
                      //   autofocus: true,
                      //   onPressed: () async {
                      //     final result = await Navigator.of(context)
                      //         .push<Lote?>(MaterialPageRoute(
                      //             builder: (_) =>
                      //                 LoteFormPage(lote: Lote())));
                      //     if (result != null) {
                      //       setState(() {
                      //         obra.lote.value = result;
                      //         ref.invalidate(lotesProvider);
                      //       });
                      //     }
                      //   },
                      //   child: const Text('Agregar lote'),
                      // ),
                      const SizedBox(height: 10),
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
                  // TODO Actualizar lista lotes (no actualiza obras)
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
