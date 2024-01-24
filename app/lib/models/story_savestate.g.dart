// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_savestate.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetStorySaveStateCollection on Isar {
  IsarCollection<StorySaveState> get storySaveStates => this.collection();
}

const StorySaveStateSchema = CollectionSchema(
  name: r'StorySaveState',
  id: 6903362908055180783,
  properties: {
    r'conversationCount': PropertySchema(
      id: 0,
      name: r'conversationCount',
      type: IsarType.long,
    ),
    r'conversationID': PropertySchema(
      id: 1,
      name: r'conversationID',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 2,
      name: r'id',
      type: IsarType.string,
    ),
    r'messageCount': PropertySchema(
      id: 3,
      name: r'messageCount',
      type: IsarType.long,
    ),
    r'node': PropertySchema(
      id: 4,
      name: r'node',
      type: IsarType.string,
    )
  },
  estimateSize: _storySaveStateEstimateSize,
  serialize: _storySaveStateSerialize,
  deserialize: _storySaveStateDeserialize,
  deserializeProp: _storySaveStateDeserializeProp,
  idName: r'iid',
  indexes: {
    r'conversationID': IndexSchema(
      id: -5539058440232393192,
      name: r'conversationID',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'conversationID',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _storySaveStateGetId,
  getLinks: _storySaveStateGetLinks,
  attach: _storySaveStateAttach,
  version: '3.0.5',
);

int _storySaveStateEstimateSize(
  StorySaveState object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.conversationID.length * 3;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.node.length * 3;
  return bytesCount;
}

void _storySaveStateSerialize(
  StorySaveState object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.conversationCount);
  writer.writeString(offsets[1], object.conversationID);
  writer.writeString(offsets[2], object.id);
  writer.writeLong(offsets[3], object.messageCount);
  writer.writeString(offsets[4], object.node);
}

StorySaveState _storySaveStateDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StorySaveState(
    conversationCount: reader.readLong(offsets[0]),
    conversationID: reader.readString(offsets[1]),
    id: reader.readString(offsets[2]),
    messageCount: reader.readLong(offsets[3]),
    node: reader.readString(offsets[4]),
  );
  return object;
}

P _storySaveStateDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _storySaveStateGetId(StorySaveState object) {
  return object.iid;
}

List<IsarLinkBase<dynamic>> _storySaveStateGetLinks(StorySaveState object) {
  return [];
}

void _storySaveStateAttach(
    IsarCollection<dynamic> col, Id id, StorySaveState object) {}

extension StorySaveStateQueryWhereSort
    on QueryBuilder<StorySaveState, StorySaveState, QWhere> {
  QueryBuilder<StorySaveState, StorySaveState, QAfterWhere> anyIid() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterWhere>
      anyConversationID() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'conversationID'),
      );
    });
  }
}

extension StorySaveStateQueryWhere
    on QueryBuilder<StorySaveState, StorySaveState, QWhereClause> {
  QueryBuilder<StorySaveState, StorySaveState, QAfterWhereClause> iidEqualTo(
      Id iid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: iid,
        upper: iid,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterWhereClause> iidNotEqualTo(
      Id iid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: iid, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: iid, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: iid, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: iid, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterWhereClause>
      iidGreaterThan(Id iid, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: iid, includeLower: include),
      );
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterWhereClause> iidLessThan(
      Id iid,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: iid, includeUpper: include),
      );
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterWhereClause> iidBetween(
    Id lowerIid,
    Id upperIid, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIid,
        includeLower: includeLower,
        upper: upperIid,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterWhereClause>
      conversationIDEqualTo(String conversationID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'conversationID',
        value: [conversationID],
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterWhereClause>
      conversationIDNotEqualTo(String conversationID) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'conversationID',
              lower: [],
              upper: [conversationID],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'conversationID',
              lower: [conversationID],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'conversationID',
              lower: [conversationID],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'conversationID',
              lower: [],
              upper: [conversationID],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterWhereClause>
      conversationIDGreaterThan(
    String conversationID, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'conversationID',
        lower: [conversationID],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterWhereClause>
      conversationIDLessThan(
    String conversationID, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'conversationID',
        lower: [],
        upper: [conversationID],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterWhereClause>
      conversationIDBetween(
    String lowerConversationID,
    String upperConversationID, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'conversationID',
        lower: [lowerConversationID],
        includeLower: includeLower,
        upper: [upperConversationID],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterWhereClause>
      conversationIDStartsWith(String ConversationIDPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'conversationID',
        lower: [ConversationIDPrefix],
        upper: ['$ConversationIDPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterWhereClause>
      conversationIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'conversationID',
        value: [''],
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterWhereClause>
      conversationIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'conversationID',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'conversationID',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'conversationID',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'conversationID',
              upper: [''],
            ));
      }
    });
  }
}

extension StorySaveStateQueryFilter
    on QueryBuilder<StorySaveState, StorySaveState, QFilterCondition> {
  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      conversationCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conversationCount',
        value: value,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      conversationCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'conversationCount',
        value: value,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      conversationCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'conversationCount',
        value: value,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      conversationCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'conversationCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      conversationIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conversationID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      conversationIDGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'conversationID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      conversationIDLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'conversationID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      conversationIDBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'conversationID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      conversationIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'conversationID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      conversationIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'conversationID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      conversationIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'conversationID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      conversationIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'conversationID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      conversationIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conversationID',
        value: '',
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      conversationIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'conversationID',
        value: '',
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      iidEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iid',
        value: value,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      iidGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iid',
        value: value,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      iidLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iid',
        value: value,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      iidBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      messageCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageCount',
        value: value,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      messageCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageCount',
        value: value,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      messageCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageCount',
        value: value,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      messageCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      nodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'node',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      nodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'node',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      nodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'node',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      nodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'node',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      nodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'node',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      nodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'node',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      nodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'node',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      nodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'node',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      nodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'node',
        value: '',
      ));
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterFilterCondition>
      nodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'node',
        value: '',
      ));
    });
  }
}

extension StorySaveStateQueryObject
    on QueryBuilder<StorySaveState, StorySaveState, QFilterCondition> {}

extension StorySaveStateQueryLinks
    on QueryBuilder<StorySaveState, StorySaveState, QFilterCondition> {}

extension StorySaveStateQuerySortBy
    on QueryBuilder<StorySaveState, StorySaveState, QSortBy> {
  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy>
      sortByConversationCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationCount', Sort.asc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy>
      sortByConversationCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationCount', Sort.desc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy>
      sortByConversationID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationID', Sort.asc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy>
      sortByConversationIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationID', Sort.desc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy>
      sortByMessageCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageCount', Sort.asc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy>
      sortByMessageCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageCount', Sort.desc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy> sortByNode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'node', Sort.asc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy> sortByNodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'node', Sort.desc);
    });
  }
}

extension StorySaveStateQuerySortThenBy
    on QueryBuilder<StorySaveState, StorySaveState, QSortThenBy> {
  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy>
      thenByConversationCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationCount', Sort.asc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy>
      thenByConversationCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationCount', Sort.desc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy>
      thenByConversationID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationID', Sort.asc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy>
      thenByConversationIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conversationID', Sort.desc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy> thenByIid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iid', Sort.asc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy> thenByIidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iid', Sort.desc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy>
      thenByMessageCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageCount', Sort.asc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy>
      thenByMessageCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageCount', Sort.desc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy> thenByNode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'node', Sort.asc);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QAfterSortBy> thenByNodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'node', Sort.desc);
    });
  }
}

extension StorySaveStateQueryWhereDistinct
    on QueryBuilder<StorySaveState, StorySaveState, QDistinct> {
  QueryBuilder<StorySaveState, StorySaveState, QDistinct>
      distinctByConversationCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'conversationCount');
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QDistinct>
      distinctByConversationID({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'conversationID',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QDistinct>
      distinctByMessageCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageCount');
    });
  }

  QueryBuilder<StorySaveState, StorySaveState, QDistinct> distinctByNode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'node', caseSensitive: caseSensitive);
    });
  }
}

extension StorySaveStateQueryProperty
    on QueryBuilder<StorySaveState, StorySaveState, QQueryProperty> {
  QueryBuilder<StorySaveState, int, QQueryOperations> iidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iid');
    });
  }

  QueryBuilder<StorySaveState, int, QQueryOperations>
      conversationCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'conversationCount');
    });
  }

  QueryBuilder<StorySaveState, String, QQueryOperations>
      conversationIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'conversationID');
    });
  }

  QueryBuilder<StorySaveState, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StorySaveState, int, QQueryOperations> messageCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageCount');
    });
  }

  QueryBuilder<StorySaveState, String, QQueryOperations> nodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'node');
    });
  }
}
