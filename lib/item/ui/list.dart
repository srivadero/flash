import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/entities.dart';
import '../controller.dart';
import 'detail.dart';
import 'form.dart';

class ListPage extends ConsumerWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Listado'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const FormPage()));
                },
                icon: const Icon(Icons.add)),
          ],
        ),
        body: ref.watch(dataProvider).when(
            data: (List<Item> data) => ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return ListTile(
                      title: Text('${item.value}'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => DetailPage(id: item.id!)));
                      },
                    );
                  },
                ),
            error: (Object error, StackTrace stackTrace) =>
                Center(child: Text(error.toString())),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
