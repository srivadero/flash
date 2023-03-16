// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetLoteCollection on Isar {
  IsarCollection<Lote> get lotes => this.collection();
}

const LoteSchema = CollectionSchema(
  name: r'Lote',
  id: -5757768337345954602,
  properties: {
    r'nombre': PropertySchema(
      id: 0,
      name: r'nombre',
      type: IsarType.string,
    ),
    r'propietario': PropertySchema(
      id: 1,
      name: r'propietario',
      type: IsarType.string,
    )
  },
  estimateSize: _loteEstimateSize,
  serialize: _loteSerialize,
  deserialize: _loteDeserialize,
  deserializeProp: _loteDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'obras': LinkSchema(
      id: -4191188555374919061,
      name: r'obras',
      target: r'Obra',
      single: false,
      linkName: r'lote',
    )
  },
  embeddedSchemas: {},
  getId: _loteGetId,
  getLinks: _loteGetLinks,
  attach: _loteAttach,
  version: '3.0.5',
);

int _loteEstimateSize(
  Lote object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nombre.length * 3;
  {
    final value = object.propietario;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _loteSerialize(
  Lote object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.nombre);
  writer.writeString(offsets[1], object.propietario);
}

Lote _loteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Lote(
    nombre: reader.readString(offsets[0]),
  );
  object.id = id;
  object.propietario = reader.readStringOrNull(offsets[1]);
  return object;
}

P _loteDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _loteGetId(Lote object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _loteGetLinks(Lote object) {
  return [object.obras];
}

void _loteAttach(IsarCollection<dynamic> col, Id id, Lote object) {
  object.id = id;
  object.obras.attach(col, col.isar.collection<Obra>(), r'obras', id);
}

extension LoteQueryWhereSort on QueryBuilder<Lote, Lote, QWhere> {
  QueryBuilder<Lote, Lote, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LoteQueryWhere on QueryBuilder<Lote, Lote, QWhereClause> {
  QueryBuilder<Lote, Lote, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Lote, Lote, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Lote, Lote, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Lote, Lote, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LoteQueryFilter on QueryBuilder<Lote, Lote, QFilterCondition> {
  QueryBuilder<Lote, Lote, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> nombreEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> nombreGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> nombreLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> nombreBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> nombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> nombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> nombreContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> nombreMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> propietarioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'propietario',
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> propietarioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'propietario',
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> propietarioEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'propietario',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> propietarioGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'propietario',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> propietarioLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'propietario',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> propietarioBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'propietario',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> propietarioStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'propietario',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> propietarioEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'propietario',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> propietarioContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'propietario',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> propietarioMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'propietario',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> propietarioIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'propietario',
        value: '',
      ));
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> propietarioIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'propietario',
        value: '',
      ));
    });
  }
}

extension LoteQueryObject on QueryBuilder<Lote, Lote, QFilterCondition> {}

extension LoteQueryLinks on QueryBuilder<Lote, Lote, QFilterCondition> {
  QueryBuilder<Lote, Lote, QAfterFilterCondition> obras(FilterQuery<Obra> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'obras');
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> obrasLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'obras', length, true, length, true);
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> obrasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'obras', 0, true, 0, true);
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> obrasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'obras', 0, false, 999999, true);
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> obrasLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'obras', 0, true, length, include);
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> obrasLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'obras', length, include, 999999, true);
    });
  }

  QueryBuilder<Lote, Lote, QAfterFilterCondition> obrasLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'obras', lower, includeLower, upper, includeUpper);
    });
  }
}

extension LoteQuerySortBy on QueryBuilder<Lote, Lote, QSortBy> {
  QueryBuilder<Lote, Lote, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<Lote, Lote, QAfterSortBy> sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<Lote, Lote, QAfterSortBy> sortByPropietario() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propietario', Sort.asc);
    });
  }

  QueryBuilder<Lote, Lote, QAfterSortBy> sortByPropietarioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propietario', Sort.desc);
    });
  }
}

extension LoteQuerySortThenBy on QueryBuilder<Lote, Lote, QSortThenBy> {
  QueryBuilder<Lote, Lote, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Lote, Lote, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Lote, Lote, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<Lote, Lote, QAfterSortBy> thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<Lote, Lote, QAfterSortBy> thenByPropietario() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propietario', Sort.asc);
    });
  }

  QueryBuilder<Lote, Lote, QAfterSortBy> thenByPropietarioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propietario', Sort.desc);
    });
  }
}

extension LoteQueryWhereDistinct on QueryBuilder<Lote, Lote, QDistinct> {
  QueryBuilder<Lote, Lote, QDistinct> distinctByNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lote, Lote, QDistinct> distinctByPropietario(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'propietario', caseSensitive: caseSensitive);
    });
  }
}

extension LoteQueryProperty on QueryBuilder<Lote, Lote, QQueryProperty> {
  QueryBuilder<Lote, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Lote, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<Lote, String?, QQueryOperations> propietarioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'propietario');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetObraCollection on Isar {
  IsarCollection<Obra> get obras => this.collection();
}

const ObraSchema = CollectionSchema(
  name: r'Obra',
  id: -3799548720268438363,
  properties: {
    r'avance': PropertySchema(
      id: 0,
      name: r'avance',
      type: IsarType.string,
      enumMap: _ObraavanceEnumValueMap,
    ),
    r'responsable': PropertySchema(
      id: 1,
      name: r'responsable',
      type: IsarType.string,
    ),
    r'suspendida': PropertySchema(
      id: 2,
      name: r'suspendida',
      type: IsarType.bool,
    )
  },
  estimateSize: _obraEstimateSize,
  serialize: _obraSerialize,
  deserialize: _obraDeserialize,
  deserializeProp: _obraDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'lote': LinkSchema(
      id: -5910285685825362955,
      name: r'lote',
      target: r'Lote',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _obraGetId,
  getLinks: _obraGetLinks,
  attach: _obraAttach,
  version: '3.0.5',
);

int _obraEstimateSize(
  Obra object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.avance.name.length * 3;
  {
    final value = object.responsable;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _obraSerialize(
  Obra object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.avance.name);
  writer.writeString(offsets[1], object.responsable);
  writer.writeBool(offsets[2], object.suspendida);
}

Obra _obraDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Obra();
  object.avance =
      _ObraavanceValueEnumMap[reader.readStringOrNull(offsets[0])] ??
          AvanceObra.inicio;
  object.id = id;
  object.responsable = reader.readStringOrNull(offsets[1]);
  object.suspendida = reader.readBool(offsets[2]);
  return object;
}

P _obraDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_ObraavanceValueEnumMap[reader.readStringOrNull(offset)] ??
          AvanceObra.inicio) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ObraavanceEnumValueMap = {
  r'inicio': r'inicio',
  r'guesa': r'guesa',
  r'fina': r'fina',
  r'remodelacion': r'remodelacion',
};
const _ObraavanceValueEnumMap = {
  r'inicio': AvanceObra.inicio,
  r'guesa': AvanceObra.guesa,
  r'fina': AvanceObra.fina,
  r'remodelacion': AvanceObra.remodelacion,
};

Id _obraGetId(Obra object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _obraGetLinks(Obra object) {
  return [object.lote];
}

void _obraAttach(IsarCollection<dynamic> col, Id id, Obra object) {
  object.id = id;
  object.lote.attach(col, col.isar.collection<Lote>(), r'lote', id);
}

extension ObraQueryWhereSort on QueryBuilder<Obra, Obra, QWhere> {
  QueryBuilder<Obra, Obra, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ObraQueryWhere on QueryBuilder<Obra, Obra, QWhereClause> {
  QueryBuilder<Obra, Obra, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Obra, Obra, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Obra, Obra, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Obra, Obra, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ObraQueryFilter on QueryBuilder<Obra, Obra, QFilterCondition> {
  QueryBuilder<Obra, Obra, QAfterFilterCondition> avanceEqualTo(
    AvanceObra value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> avanceGreaterThan(
    AvanceObra value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> avanceLessThan(
    AvanceObra value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> avanceBetween(
    AvanceObra lower,
    AvanceObra upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> avanceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> avanceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> avanceContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> avanceMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avance',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> avanceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avance',
        value: '',
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> avanceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avance',
        value: '',
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> responsableIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'responsable',
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> responsableIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'responsable',
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> responsableEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'responsable',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> responsableGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'responsable',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> responsableLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'responsable',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> responsableBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'responsable',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> responsableStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'responsable',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> responsableEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'responsable',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> responsableContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'responsable',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> responsableMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'responsable',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> responsableIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'responsable',
        value: '',
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> responsableIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'responsable',
        value: '',
      ));
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> suspendidaEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'suspendida',
        value: value,
      ));
    });
  }
}

extension ObraQueryObject on QueryBuilder<Obra, Obra, QFilterCondition> {}

extension ObraQueryLinks on QueryBuilder<Obra, Obra, QFilterCondition> {
  QueryBuilder<Obra, Obra, QAfterFilterCondition> lote(FilterQuery<Lote> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'lote');
    });
  }

  QueryBuilder<Obra, Obra, QAfterFilterCondition> loteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lote', 0, true, 0, true);
    });
  }
}

extension ObraQuerySortBy on QueryBuilder<Obra, Obra, QSortBy> {
  QueryBuilder<Obra, Obra, QAfterSortBy> sortByAvance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avance', Sort.asc);
    });
  }

  QueryBuilder<Obra, Obra, QAfterSortBy> sortByAvanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avance', Sort.desc);
    });
  }

  QueryBuilder<Obra, Obra, QAfterSortBy> sortByResponsable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'responsable', Sort.asc);
    });
  }

  QueryBuilder<Obra, Obra, QAfterSortBy> sortByResponsableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'responsable', Sort.desc);
    });
  }

  QueryBuilder<Obra, Obra, QAfterSortBy> sortBySuspendida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suspendida', Sort.asc);
    });
  }

  QueryBuilder<Obra, Obra, QAfterSortBy> sortBySuspendidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suspendida', Sort.desc);
    });
  }
}

extension ObraQuerySortThenBy on QueryBuilder<Obra, Obra, QSortThenBy> {
  QueryBuilder<Obra, Obra, QAfterSortBy> thenByAvance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avance', Sort.asc);
    });
  }

  QueryBuilder<Obra, Obra, QAfterSortBy> thenByAvanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avance', Sort.desc);
    });
  }

  QueryBuilder<Obra, Obra, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Obra, Obra, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Obra, Obra, QAfterSortBy> thenByResponsable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'responsable', Sort.asc);
    });
  }

  QueryBuilder<Obra, Obra, QAfterSortBy> thenByResponsableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'responsable', Sort.desc);
    });
  }

  QueryBuilder<Obra, Obra, QAfterSortBy> thenBySuspendida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suspendida', Sort.asc);
    });
  }

  QueryBuilder<Obra, Obra, QAfterSortBy> thenBySuspendidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suspendida', Sort.desc);
    });
  }
}

extension ObraQueryWhereDistinct on QueryBuilder<Obra, Obra, QDistinct> {
  QueryBuilder<Obra, Obra, QDistinct> distinctByAvance(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avance', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Obra, Obra, QDistinct> distinctByResponsable(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'responsable', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Obra, Obra, QDistinct> distinctBySuspendida() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'suspendida');
    });
  }
}

extension ObraQueryProperty on QueryBuilder<Obra, Obra, QQueryProperty> {
  QueryBuilder<Obra, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Obra, AvanceObra, QQueryOperations> avanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avance');
    });
  }

  QueryBuilder<Obra, String?, QQueryOperations> responsableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'responsable');
    });
  }

  QueryBuilder<Obra, bool, QQueryOperations> suspendidaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'suspendida');
    });
  }
}
