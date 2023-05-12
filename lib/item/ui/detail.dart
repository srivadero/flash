import 'package:flash/model/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller.dart';
import 'form.dart';

class DetailPage extends ConsumerStatefulWidget {
  final int id;
  const DetailPage({required this.id, super.key});

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  late int id;

  @override
  void initState() {
    super.initState();
    id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
          actions: [
            IconButton(
                onPressed: () async {
                  final result =
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => FormPage(
                                id: id,
                              )));
                  if (result != null) {
                    setState(() {});
                  }
                },
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () async {
                  final result = await showDialog<bool?>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        // title: const Text('Title'),
                        content: const Text('content'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: const Text('Delete')),
                          TextButton(
                              autofocus: true,
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: const Text('Cancel')),
                        ],
                      );
                    },
                  );
                  if (mounted && result != null && result == true) {
                    ref.read(dataCotroller).delete(id);
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.delete)),
          ],
        ),
        body: ref.watch(itemProvider(id)).when(
            data: (Item item) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(title: Text('ID: ${item.id}')),
                    ListTile(title: Text('VALUE: ${item.value}')),
                  ],
                ),
              );
            },
            error: (Object error, StackTrace stackTrace) =>
                Center(child: Text(error.toString())),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
