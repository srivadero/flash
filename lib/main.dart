import 'package:flash/database.dart';
import 'package:flash/lote/list.dart';
import 'package:flash/model/database_provider.dart';
import 'package:flash/obra/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  final isar = await IsarDatabase.create(directory: 'Databases');

  runApp(ProviderScope(
    overrides: [
      databaseProvider.overrideWithValue(isar),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flash',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class View {
  final Icon icon;
  final String label;
  final Widget page;
  View({required this.icon, required this.label, required this.page});
}

class _MyHomePageState extends State<MyHomePage> {
  late int _selectedIndex;
  final List<View> _views = [
    View(
        icon: const Icon(Icons.home),
        label: 'Lotes',
        page: const LoteListPage()),
    View(
        icon: const Icon(Icons.sunny),
        label: 'Obras',
        page: const ObraListPage()),
    View(
        icon: const Icon(Icons.settings),
        label: 'Preferencias',
        page: Scaffold(
          appBar: AppBar(
            title: const Text('Preferencias'),
          ),
          body: const Center(child: Text('No implementado')),
        )),
  ];

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _views[_selectedIndex].page,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _selectedIndex,
        items: _views
            .map((e) => BottomNavigationBarItem(icon: e.icon, label: e.label))
            .toList(),
        onTap: (value) {
          setState(() => _selectedIndex = value);
        },
      ),
    );
  }
}
