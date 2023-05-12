import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'entities.g.dart';

@collection
class Lote {
  Id? id;
  String nombre;
  String? propietario;
  Lote({required this.nombre});
  @Backlink(to: 'lote')
  final obras = IsarLinks<Obra>();
}

@collection
class Obra {
  Id? id;
  String? responsable;
  bool suspendida = false;
  final lote = IsarLink<Lote>();
  @Enumerated(EnumType.name)
  AvanceObra avance = AvanceObra.inicio;
}

enum AvanceObra {
  inicio('Inicio de obra', Colors.green,
      'Movimiento de suelo, excavaciones, cimientos'),
  guesa('Obra gruesa', Colors.blue, 'Paredes, losas, tanques'),
  fina('Obra fina', Colors.yellow, 'Terminaciones finas, amoblamiento fijo'),
  remodelacion('Remodelacion', Colors.red,
      'Vivienda habitada con trabajos pendientes, Ampliacion'),
  unasigned('No definida', Colors.grey, 'No definida');

  const AvanceObra(this.nombre, this.color, this.info);
  final String nombre;
  final Color color;
  final String info;
}

@collection
class Item {
  Id? id;
  String? value;
}
