import 'package:flash/model/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller.dart';

class FormPage extends ConsumerStatefulWidget {
  final int? id;
  const FormPage({this.id, super.key});

  @override
  ConsumerState<FormPage> createState() => _FormPageState();
}

class _FormPageState extends ConsumerState<FormPage> {
  late int? id;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Form')),
        body: ref.watch(itemProvider(id)).when(
            data: (Item item) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          autofocus: true,
                          initialValue: item.value,
                          validator: (value) {
                            return value == null || value.isEmpty
                                ? 'Must not be empty'
                                : null;
                          },
                          onSaved: (newValue) => item.value = newValue,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                ref.read(dataCotroller).save(item);
                                Navigator.of(context).pop(true);
                              }
                            },
                            child: const Text('Save'))
                      ],
                    )),
              );
            },
            error: (Object error, StackTrace stackTrace) =>
                Center(child: Text(error.toString())),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
