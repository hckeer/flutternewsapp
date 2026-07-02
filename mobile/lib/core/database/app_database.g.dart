// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SyncMetadataTable extends SyncMetadata
    with TableInfo<$SyncMetadataTable, SyncMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, lastSyncedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastSyncedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetadataData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      )!,
    );
  }

  @override
  $SyncMetadataTable createAlias(String alias) {
    return $SyncMetadataTable(attachedDatabase, alias);
  }
}

class SyncMetadataData extends DataClass
    implements Insertable<SyncMetadataData> {
  final String key;
  final DateTime lastSyncedAt;
  const SyncMetadataData({required this.key, required this.lastSyncedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    return map;
  }

  SyncMetadataCompanion toCompanion(bool nullToAbsent) {
    return SyncMetadataCompanion(
      key: Value(key),
      lastSyncedAt: Value(lastSyncedAt),
    );
  }

  factory SyncMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetadataData(
      key: serializer.fromJson<String>(json['key']),
      lastSyncedAt: serializer.fromJson<DateTime>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'lastSyncedAt': serializer.toJson<DateTime>(lastSyncedAt),
    };
  }

  SyncMetadataData copyWith({String? key, DateTime? lastSyncedAt}) =>
      SyncMetadataData(
        key: key ?? this.key,
        lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      );
  SyncMetadataData copyWithCompanion(SyncMetadataCompanion data) {
    return SyncMetadataData(
      key: data.key.present ? data.key.value : this.key,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataData(')
          ..write('key: $key, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, lastSyncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetadataData &&
          other.key == this.key &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class SyncMetadataCompanion extends UpdateCompanion<SyncMetadataData> {
  final Value<String> key;
  final Value<DateTime> lastSyncedAt;
  final Value<int> rowid;
  const SyncMetadataCompanion({
    this.key = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetadataCompanion.insert({
    required String key,
    required DateTime lastSyncedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       lastSyncedAt = Value(lastSyncedAt);
  static Insertable<SyncMetadataData> custom({
    Expression<String>? key,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetadataCompanion copyWith({
    Value<String>? key,
    Value<DateTime>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return SyncMetadataCompanion(
      key: key ?? this.key,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataCompanion(')
          ..write('key: $key, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DistrictsTable extends Districts
    with TableInfo<$DistrictsTable, District> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DistrictsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameNeMeta = const VerificationMeta('nameNe');
  @override
  late final GeneratedColumn<String> nameNe = GeneratedColumn<String>(
    'name_ne',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _provinceEnMeta = const VerificationMeta(
    'provinceEn',
  );
  @override
  late final GeneratedColumn<String> provinceEn = GeneratedColumn<String>(
    'province_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    nameEn,
    nameNe,
    provinceEn,
    latitude,
    longitude,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'districts';
  @override
  VerificationContext validateIntegrity(
    Insertable<District> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    }
    if (data.containsKey('name_ne')) {
      context.handle(
        _nameNeMeta,
        nameNe.isAcceptableOrUnknown(data['name_ne']!, _nameNeMeta),
      );
    }
    if (data.containsKey('province_en')) {
      context.handle(
        _provinceEnMeta,
        provinceEn.isAcceptableOrUnknown(data['province_en']!, _provinceEnMeta),
      );
    } else if (isInserting) {
      context.missing(_provinceEnMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  District map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return District(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      ),
      nameNe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ne'],
      ),
      provinceEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}province_en'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
    );
  }

  @override
  $DistrictsTable createAlias(String alias) {
    return $DistrictsTable(attachedDatabase, alias);
  }
}

class District extends DataClass implements Insertable<District> {
  final int id;
  final String code;
  final String? nameEn;
  final String? nameNe;
  final String provinceEn;
  final double? latitude;
  final double? longitude;
  const District({
    required this.id,
    required this.code,
    this.nameEn,
    this.nameNe,
    required this.provinceEn,
    this.latitude,
    this.longitude,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    if (!nullToAbsent || nameNe != null) {
      map['name_ne'] = Variable<String>(nameNe);
    }
    map['province_en'] = Variable<String>(provinceEn);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    return map;
  }

  DistrictsCompanion toCompanion(bool nullToAbsent) {
    return DistrictsCompanion(
      id: Value(id),
      code: Value(code),
      nameEn: nameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEn),
      nameNe: nameNe == null && nullToAbsent
          ? const Value.absent()
          : Value(nameNe),
      provinceEn: Value(provinceEn),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
    );
  }

  factory District.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return District(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      nameNe: serializer.fromJson<String?>(json['nameNe']),
      provinceEn: serializer.fromJson<String>(json['provinceEn']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'nameEn': serializer.toJson<String?>(nameEn),
      'nameNe': serializer.toJson<String?>(nameNe),
      'provinceEn': serializer.toJson<String>(provinceEn),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
    };
  }

  District copyWith({
    int? id,
    String? code,
    Value<String?> nameEn = const Value.absent(),
    Value<String?> nameNe = const Value.absent(),
    String? provinceEn,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
  }) => District(
    id: id ?? this.id,
    code: code ?? this.code,
    nameEn: nameEn.present ? nameEn.value : this.nameEn,
    nameNe: nameNe.present ? nameNe.value : this.nameNe,
    provinceEn: provinceEn ?? this.provinceEn,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
  );
  District copyWithCompanion(DistrictsCompanion data) {
    return District(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameNe: data.nameNe.present ? data.nameNe.value : this.nameNe,
      provinceEn: data.provinceEn.present
          ? data.provinceEn.value
          : this.provinceEn,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
    );
  }

  @override
  String toString() {
    return (StringBuffer('District(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameNe: $nameNe, ')
          ..write('provinceEn: $provinceEn, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, code, nameEn, nameNe, provinceEn, latitude, longitude);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is District &&
          other.id == this.id &&
          other.code == this.code &&
          other.nameEn == this.nameEn &&
          other.nameNe == this.nameNe &&
          other.provinceEn == this.provinceEn &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude);
}

class DistrictsCompanion extends UpdateCompanion<District> {
  final Value<int> id;
  final Value<String> code;
  final Value<String?> nameEn;
  final Value<String?> nameNe;
  final Value<String> provinceEn;
  final Value<double?> latitude;
  final Value<double?> longitude;
  const DistrictsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameNe = const Value.absent(),
    this.provinceEn = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
  });
  DistrictsCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    this.nameEn = const Value.absent(),
    this.nameNe = const Value.absent(),
    required String provinceEn,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
  }) : code = Value(code),
       provinceEn = Value(provinceEn);
  static Insertable<District> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? nameEn,
    Expression<String>? nameNe,
    Expression<String>? provinceEn,
    Expression<double>? latitude,
    Expression<double>? longitude,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (nameEn != null) 'name_en': nameEn,
      if (nameNe != null) 'name_ne': nameNe,
      if (provinceEn != null) 'province_en': provinceEn,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    });
  }

  DistrictsCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String?>? nameEn,
    Value<String?>? nameNe,
    Value<String>? provinceEn,
    Value<double?>? latitude,
    Value<double?>? longitude,
  }) {
    return DistrictsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      nameEn: nameEn ?? this.nameEn,
      nameNe: nameNe ?? this.nameNe,
      provinceEn: provinceEn ?? this.provinceEn,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameNe.present) {
      map['name_ne'] = Variable<String>(nameNe.value);
    }
    if (provinceEn.present) {
      map['province_en'] = Variable<String>(provinceEn.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DistrictsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameNe: $nameNe, ')
          ..write('provinceEn: $provinceEn, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude')
          ..write(')'))
        .toString();
  }
}

class $ArticlesTable extends Articles with TableInfo<$ArticlesTable, Article> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleEnMeta = const VerificationMeta(
    'titleEn',
  );
  @override
  late final GeneratedColumn<String> titleEn = GeneratedColumn<String>(
    'title_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleNeMeta = const VerificationMeta(
    'titleNe',
  );
  @override
  late final GeneratedColumn<String> titleNe = GeneratedColumn<String>(
    'title_ne',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _summaryEnMeta = const VerificationMeta(
    'summaryEn',
  );
  @override
  late final GeneratedColumn<String> summaryEn = GeneratedColumn<String>(
    'summary_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _summaryNeMeta = const VerificationMeta(
    'summaryNe',
  );
  @override
  late final GeneratedColumn<String> summaryNe = GeneratedColumn<String>(
    'summary_ne',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyEnMeta = const VerificationMeta('bodyEn');
  @override
  late final GeneratedColumn<String> bodyEn = GeneratedColumn<String>(
    'body_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyNeMeta = const VerificationMeta('bodyNe');
  @override
  late final GeneratedColumn<String> bodyNe = GeneratedColumn<String>(
    'body_ne',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverMediaIdMeta = const VerificationMeta(
    'coverMediaId',
  );
  @override
  late final GeneratedColumn<int> coverMediaId = GeneratedColumn<int>(
    'cover_media_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverMediaUrlMeta = const VerificationMeta(
    'coverMediaUrl',
  );
  @override
  late final GeneratedColumn<String> coverMediaUrl = GeneratedColumn<String>(
    'cover_media_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _publishedAtMeta = const VerificationMeta(
    'publishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
    'published_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    slug,
    titleEn,
    titleNe,
    summaryEn,
    summaryNe,
    bodyEn,
    bodyNe,
    coverMediaId,
    coverMediaUrl,
    status,
    publishedAt,
    sortOrder,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'articles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Article> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('title_en')) {
      context.handle(
        _titleEnMeta,
        titleEn.isAcceptableOrUnknown(data['title_en']!, _titleEnMeta),
      );
    }
    if (data.containsKey('title_ne')) {
      context.handle(
        _titleNeMeta,
        titleNe.isAcceptableOrUnknown(data['title_ne']!, _titleNeMeta),
      );
    }
    if (data.containsKey('summary_en')) {
      context.handle(
        _summaryEnMeta,
        summaryEn.isAcceptableOrUnknown(data['summary_en']!, _summaryEnMeta),
      );
    }
    if (data.containsKey('summary_ne')) {
      context.handle(
        _summaryNeMeta,
        summaryNe.isAcceptableOrUnknown(data['summary_ne']!, _summaryNeMeta),
      );
    }
    if (data.containsKey('body_en')) {
      context.handle(
        _bodyEnMeta,
        bodyEn.isAcceptableOrUnknown(data['body_en']!, _bodyEnMeta),
      );
    }
    if (data.containsKey('body_ne')) {
      context.handle(
        _bodyNeMeta,
        bodyNe.isAcceptableOrUnknown(data['body_ne']!, _bodyNeMeta),
      );
    }
    if (data.containsKey('cover_media_id')) {
      context.handle(
        _coverMediaIdMeta,
        coverMediaId.isAcceptableOrUnknown(
          data['cover_media_id']!,
          _coverMediaIdMeta,
        ),
      );
    }
    if (data.containsKey('cover_media_url')) {
      context.handle(
        _coverMediaUrlMeta,
        coverMediaUrl.isAcceptableOrUnknown(
          data['cover_media_url']!,
          _coverMediaUrlMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('published_at')) {
      context.handle(
        _publishedAtMeta,
        publishedAt.isAcceptableOrUnknown(
          data['published_at']!,
          _publishedAtMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Article map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Article(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      titleEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_en'],
      ),
      titleNe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_ne'],
      ),
      summaryEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary_en'],
      ),
      summaryNe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary_ne'],
      ),
      bodyEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_en'],
      ),
      bodyNe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_ne'],
      ),
      coverMediaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cover_media_id'],
      ),
      coverMediaUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_media_url'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}published_at'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ArticlesTable createAlias(String alias) {
    return $ArticlesTable(attachedDatabase, alias);
  }
}

class Article extends DataClass implements Insertable<Article> {
  final int id;
  final String slug;
  final String? titleEn;
  final String? titleNe;
  final String? summaryEn;
  final String? summaryNe;
  final String? bodyEn;
  final String? bodyNe;
  final int? coverMediaId;
  final String? coverMediaUrl;
  final String status;
  final DateTime? publishedAt;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Article({
    required this.id,
    required this.slug,
    this.titleEn,
    this.titleNe,
    this.summaryEn,
    this.summaryNe,
    this.bodyEn,
    this.bodyNe,
    this.coverMediaId,
    this.coverMediaUrl,
    required this.status,
    this.publishedAt,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['slug'] = Variable<String>(slug);
    if (!nullToAbsent || titleEn != null) {
      map['title_en'] = Variable<String>(titleEn);
    }
    if (!nullToAbsent || titleNe != null) {
      map['title_ne'] = Variable<String>(titleNe);
    }
    if (!nullToAbsent || summaryEn != null) {
      map['summary_en'] = Variable<String>(summaryEn);
    }
    if (!nullToAbsent || summaryNe != null) {
      map['summary_ne'] = Variable<String>(summaryNe);
    }
    if (!nullToAbsent || bodyEn != null) {
      map['body_en'] = Variable<String>(bodyEn);
    }
    if (!nullToAbsent || bodyNe != null) {
      map['body_ne'] = Variable<String>(bodyNe);
    }
    if (!nullToAbsent || coverMediaId != null) {
      map['cover_media_id'] = Variable<int>(coverMediaId);
    }
    if (!nullToAbsent || coverMediaUrl != null) {
      map['cover_media_url'] = Variable<String>(coverMediaUrl);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || publishedAt != null) {
      map['published_at'] = Variable<DateTime>(publishedAt);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ArticlesCompanion toCompanion(bool nullToAbsent) {
    return ArticlesCompanion(
      id: Value(id),
      slug: Value(slug),
      titleEn: titleEn == null && nullToAbsent
          ? const Value.absent()
          : Value(titleEn),
      titleNe: titleNe == null && nullToAbsent
          ? const Value.absent()
          : Value(titleNe),
      summaryEn: summaryEn == null && nullToAbsent
          ? const Value.absent()
          : Value(summaryEn),
      summaryNe: summaryNe == null && nullToAbsent
          ? const Value.absent()
          : Value(summaryNe),
      bodyEn: bodyEn == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyEn),
      bodyNe: bodyNe == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyNe),
      coverMediaId: coverMediaId == null && nullToAbsent
          ? const Value.absent()
          : Value(coverMediaId),
      coverMediaUrl: coverMediaUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(coverMediaUrl),
      status: Value(status),
      publishedAt: publishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAt),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Article.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Article(
      id: serializer.fromJson<int>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      titleEn: serializer.fromJson<String?>(json['titleEn']),
      titleNe: serializer.fromJson<String?>(json['titleNe']),
      summaryEn: serializer.fromJson<String?>(json['summaryEn']),
      summaryNe: serializer.fromJson<String?>(json['summaryNe']),
      bodyEn: serializer.fromJson<String?>(json['bodyEn']),
      bodyNe: serializer.fromJson<String?>(json['bodyNe']),
      coverMediaId: serializer.fromJson<int?>(json['coverMediaId']),
      coverMediaUrl: serializer.fromJson<String?>(json['coverMediaUrl']),
      status: serializer.fromJson<String>(json['status']),
      publishedAt: serializer.fromJson<DateTime?>(json['publishedAt']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'slug': serializer.toJson<String>(slug),
      'titleEn': serializer.toJson<String?>(titleEn),
      'titleNe': serializer.toJson<String?>(titleNe),
      'summaryEn': serializer.toJson<String?>(summaryEn),
      'summaryNe': serializer.toJson<String?>(summaryNe),
      'bodyEn': serializer.toJson<String?>(bodyEn),
      'bodyNe': serializer.toJson<String?>(bodyNe),
      'coverMediaId': serializer.toJson<int?>(coverMediaId),
      'coverMediaUrl': serializer.toJson<String?>(coverMediaUrl),
      'status': serializer.toJson<String>(status),
      'publishedAt': serializer.toJson<DateTime?>(publishedAt),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Article copyWith({
    int? id,
    String? slug,
    Value<String?> titleEn = const Value.absent(),
    Value<String?> titleNe = const Value.absent(),
    Value<String?> summaryEn = const Value.absent(),
    Value<String?> summaryNe = const Value.absent(),
    Value<String?> bodyEn = const Value.absent(),
    Value<String?> bodyNe = const Value.absent(),
    Value<int?> coverMediaId = const Value.absent(),
    Value<String?> coverMediaUrl = const Value.absent(),
    String? status,
    Value<DateTime?> publishedAt = const Value.absent(),
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Article(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    titleEn: titleEn.present ? titleEn.value : this.titleEn,
    titleNe: titleNe.present ? titleNe.value : this.titleNe,
    summaryEn: summaryEn.present ? summaryEn.value : this.summaryEn,
    summaryNe: summaryNe.present ? summaryNe.value : this.summaryNe,
    bodyEn: bodyEn.present ? bodyEn.value : this.bodyEn,
    bodyNe: bodyNe.present ? bodyNe.value : this.bodyNe,
    coverMediaId: coverMediaId.present ? coverMediaId.value : this.coverMediaId,
    coverMediaUrl: coverMediaUrl.present
        ? coverMediaUrl.value
        : this.coverMediaUrl,
    status: status ?? this.status,
    publishedAt: publishedAt.present ? publishedAt.value : this.publishedAt,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Article copyWithCompanion(ArticlesCompanion data) {
    return Article(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      titleEn: data.titleEn.present ? data.titleEn.value : this.titleEn,
      titleNe: data.titleNe.present ? data.titleNe.value : this.titleNe,
      summaryEn: data.summaryEn.present ? data.summaryEn.value : this.summaryEn,
      summaryNe: data.summaryNe.present ? data.summaryNe.value : this.summaryNe,
      bodyEn: data.bodyEn.present ? data.bodyEn.value : this.bodyEn,
      bodyNe: data.bodyNe.present ? data.bodyNe.value : this.bodyNe,
      coverMediaId: data.coverMediaId.present
          ? data.coverMediaId.value
          : this.coverMediaId,
      coverMediaUrl: data.coverMediaUrl.present
          ? data.coverMediaUrl.value
          : this.coverMediaUrl,
      status: data.status.present ? data.status.value : this.status,
      publishedAt: data.publishedAt.present
          ? data.publishedAt.value
          : this.publishedAt,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Article(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('titleEn: $titleEn, ')
          ..write('titleNe: $titleNe, ')
          ..write('summaryEn: $summaryEn, ')
          ..write('summaryNe: $summaryNe, ')
          ..write('bodyEn: $bodyEn, ')
          ..write('bodyNe: $bodyNe, ')
          ..write('coverMediaId: $coverMediaId, ')
          ..write('coverMediaUrl: $coverMediaUrl, ')
          ..write('status: $status, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    slug,
    titleEn,
    titleNe,
    summaryEn,
    summaryNe,
    bodyEn,
    bodyNe,
    coverMediaId,
    coverMediaUrl,
    status,
    publishedAt,
    sortOrder,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Article &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.titleEn == this.titleEn &&
          other.titleNe == this.titleNe &&
          other.summaryEn == this.summaryEn &&
          other.summaryNe == this.summaryNe &&
          other.bodyEn == this.bodyEn &&
          other.bodyNe == this.bodyNe &&
          other.coverMediaId == this.coverMediaId &&
          other.coverMediaUrl == this.coverMediaUrl &&
          other.status == this.status &&
          other.publishedAt == this.publishedAt &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ArticlesCompanion extends UpdateCompanion<Article> {
  final Value<int> id;
  final Value<String> slug;
  final Value<String?> titleEn;
  final Value<String?> titleNe;
  final Value<String?> summaryEn;
  final Value<String?> summaryNe;
  final Value<String?> bodyEn;
  final Value<String?> bodyNe;
  final Value<int?> coverMediaId;
  final Value<String?> coverMediaUrl;
  final Value<String> status;
  final Value<DateTime?> publishedAt;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ArticlesCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.titleEn = const Value.absent(),
    this.titleNe = const Value.absent(),
    this.summaryEn = const Value.absent(),
    this.summaryNe = const Value.absent(),
    this.bodyEn = const Value.absent(),
    this.bodyNe = const Value.absent(),
    this.coverMediaId = const Value.absent(),
    this.coverMediaUrl = const Value.absent(),
    this.status = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ArticlesCompanion.insert({
    this.id = const Value.absent(),
    required String slug,
    this.titleEn = const Value.absent(),
    this.titleNe = const Value.absent(),
    this.summaryEn = const Value.absent(),
    this.summaryNe = const Value.absent(),
    this.bodyEn = const Value.absent(),
    this.bodyNe = const Value.absent(),
    this.coverMediaId = const Value.absent(),
    this.coverMediaUrl = const Value.absent(),
    required String status,
    this.publishedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : slug = Value(slug),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Article> custom({
    Expression<int>? id,
    Expression<String>? slug,
    Expression<String>? titleEn,
    Expression<String>? titleNe,
    Expression<String>? summaryEn,
    Expression<String>? summaryNe,
    Expression<String>? bodyEn,
    Expression<String>? bodyNe,
    Expression<int>? coverMediaId,
    Expression<String>? coverMediaUrl,
    Expression<String>? status,
    Expression<DateTime>? publishedAt,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (titleEn != null) 'title_en': titleEn,
      if (titleNe != null) 'title_ne': titleNe,
      if (summaryEn != null) 'summary_en': summaryEn,
      if (summaryNe != null) 'summary_ne': summaryNe,
      if (bodyEn != null) 'body_en': bodyEn,
      if (bodyNe != null) 'body_ne': bodyNe,
      if (coverMediaId != null) 'cover_media_id': coverMediaId,
      if (coverMediaUrl != null) 'cover_media_url': coverMediaUrl,
      if (status != null) 'status': status,
      if (publishedAt != null) 'published_at': publishedAt,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ArticlesCompanion copyWith({
    Value<int>? id,
    Value<String>? slug,
    Value<String?>? titleEn,
    Value<String?>? titleNe,
    Value<String?>? summaryEn,
    Value<String?>? summaryNe,
    Value<String?>? bodyEn,
    Value<String?>? bodyNe,
    Value<int?>? coverMediaId,
    Value<String?>? coverMediaUrl,
    Value<String>? status,
    Value<DateTime?>? publishedAt,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ArticlesCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      titleEn: titleEn ?? this.titleEn,
      titleNe: titleNe ?? this.titleNe,
      summaryEn: summaryEn ?? this.summaryEn,
      summaryNe: summaryNe ?? this.summaryNe,
      bodyEn: bodyEn ?? this.bodyEn,
      bodyNe: bodyNe ?? this.bodyNe,
      coverMediaId: coverMediaId ?? this.coverMediaId,
      coverMediaUrl: coverMediaUrl ?? this.coverMediaUrl,
      status: status ?? this.status,
      publishedAt: publishedAt ?? this.publishedAt,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (titleEn.present) {
      map['title_en'] = Variable<String>(titleEn.value);
    }
    if (titleNe.present) {
      map['title_ne'] = Variable<String>(titleNe.value);
    }
    if (summaryEn.present) {
      map['summary_en'] = Variable<String>(summaryEn.value);
    }
    if (summaryNe.present) {
      map['summary_ne'] = Variable<String>(summaryNe.value);
    }
    if (bodyEn.present) {
      map['body_en'] = Variable<String>(bodyEn.value);
    }
    if (bodyNe.present) {
      map['body_ne'] = Variable<String>(bodyNe.value);
    }
    if (coverMediaId.present) {
      map['cover_media_id'] = Variable<int>(coverMediaId.value);
    }
    if (coverMediaUrl.present) {
      map['cover_media_url'] = Variable<String>(coverMediaUrl.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('titleEn: $titleEn, ')
          ..write('titleNe: $titleNe, ')
          ..write('summaryEn: $summaryEn, ')
          ..write('summaryNe: $summaryNe, ')
          ..write('bodyEn: $bodyEn, ')
          ..write('bodyNe: $bodyNe, ')
          ..write('coverMediaId: $coverMediaId, ')
          ..write('coverMediaUrl: $coverMediaUrl, ')
          ..write('status: $status, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $NewsItemsTable extends NewsItems
    with TableInfo<$NewsItemsTable, NewsItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NewsItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleEnMeta = const VerificationMeta(
    'titleEn',
  );
  @override
  late final GeneratedColumn<String> titleEn = GeneratedColumn<String>(
    'title_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleNeMeta = const VerificationMeta(
    'titleNe',
  );
  @override
  late final GeneratedColumn<String> titleNe = GeneratedColumn<String>(
    'title_ne',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _summaryEnMeta = const VerificationMeta(
    'summaryEn',
  );
  @override
  late final GeneratedColumn<String> summaryEn = GeneratedColumn<String>(
    'summary_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _summaryNeMeta = const VerificationMeta(
    'summaryNe',
  );
  @override
  late final GeneratedColumn<String> summaryNe = GeneratedColumn<String>(
    'summary_ne',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyEnMeta = const VerificationMeta('bodyEn');
  @override
  late final GeneratedColumn<String> bodyEn = GeneratedColumn<String>(
    'body_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyNeMeta = const VerificationMeta('bodyNe');
  @override
  late final GeneratedColumn<String> bodyNe = GeneratedColumn<String>(
    'body_ne',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceNameMeta = const VerificationMeta(
    'sourceName',
  );
  @override
  late final GeneratedColumn<String> sourceName = GeneratedColumn<String>(
    'source_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceUrlMeta = const VerificationMeta(
    'sourceUrl',
  );
  @override
  late final GeneratedColumn<String> sourceUrl = GeneratedColumn<String>(
    'source_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _externalUrlMeta = const VerificationMeta(
    'externalUrl',
  );
  @override
  late final GeneratedColumn<String> externalUrl = GeneratedColumn<String>(
    'external_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverMediaIdMeta = const VerificationMeta(
    'coverMediaId',
  );
  @override
  late final GeneratedColumn<int> coverMediaId = GeneratedColumn<int>(
    'cover_media_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverMediaUrlMeta = const VerificationMeta(
    'coverMediaUrl',
  );
  @override
  late final GeneratedColumn<String> coverMediaUrl = GeneratedColumn<String>(
    'cover_media_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _publishedAtMeta = const VerificationMeta(
    'publishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
    'published_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    slug,
    titleEn,
    titleNe,
    summaryEn,
    summaryNe,
    bodyEn,
    bodyNe,
    sourceName,
    sourceUrl,
    externalUrl,
    coverMediaId,
    coverMediaUrl,
    status,
    publishedAt,
    sortOrder,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'news_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<NewsItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('title_en')) {
      context.handle(
        _titleEnMeta,
        titleEn.isAcceptableOrUnknown(data['title_en']!, _titleEnMeta),
      );
    }
    if (data.containsKey('title_ne')) {
      context.handle(
        _titleNeMeta,
        titleNe.isAcceptableOrUnknown(data['title_ne']!, _titleNeMeta),
      );
    }
    if (data.containsKey('summary_en')) {
      context.handle(
        _summaryEnMeta,
        summaryEn.isAcceptableOrUnknown(data['summary_en']!, _summaryEnMeta),
      );
    }
    if (data.containsKey('summary_ne')) {
      context.handle(
        _summaryNeMeta,
        summaryNe.isAcceptableOrUnknown(data['summary_ne']!, _summaryNeMeta),
      );
    }
    if (data.containsKey('body_en')) {
      context.handle(
        _bodyEnMeta,
        bodyEn.isAcceptableOrUnknown(data['body_en']!, _bodyEnMeta),
      );
    }
    if (data.containsKey('body_ne')) {
      context.handle(
        _bodyNeMeta,
        bodyNe.isAcceptableOrUnknown(data['body_ne']!, _bodyNeMeta),
      );
    }
    if (data.containsKey('source_name')) {
      context.handle(
        _sourceNameMeta,
        sourceName.isAcceptableOrUnknown(data['source_name']!, _sourceNameMeta),
      );
    }
    if (data.containsKey('source_url')) {
      context.handle(
        _sourceUrlMeta,
        sourceUrl.isAcceptableOrUnknown(data['source_url']!, _sourceUrlMeta),
      );
    }
    if (data.containsKey('external_url')) {
      context.handle(
        _externalUrlMeta,
        externalUrl.isAcceptableOrUnknown(
          data['external_url']!,
          _externalUrlMeta,
        ),
      );
    }
    if (data.containsKey('cover_media_id')) {
      context.handle(
        _coverMediaIdMeta,
        coverMediaId.isAcceptableOrUnknown(
          data['cover_media_id']!,
          _coverMediaIdMeta,
        ),
      );
    }
    if (data.containsKey('cover_media_url')) {
      context.handle(
        _coverMediaUrlMeta,
        coverMediaUrl.isAcceptableOrUnknown(
          data['cover_media_url']!,
          _coverMediaUrlMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('published_at')) {
      context.handle(
        _publishedAtMeta,
        publishedAt.isAcceptableOrUnknown(
          data['published_at']!,
          _publishedAtMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NewsItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NewsItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      titleEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_en'],
      ),
      titleNe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_ne'],
      ),
      summaryEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary_en'],
      ),
      summaryNe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary_ne'],
      ),
      bodyEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_en'],
      ),
      bodyNe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_ne'],
      ),
      sourceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_name'],
      ),
      sourceUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_url'],
      ),
      externalUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_url'],
      ),
      coverMediaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cover_media_id'],
      ),
      coverMediaUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_media_url'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}published_at'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NewsItemsTable createAlias(String alias) {
    return $NewsItemsTable(attachedDatabase, alias);
  }
}

class NewsItem extends DataClass implements Insertable<NewsItem> {
  final int id;
  final String slug;
  final String? titleEn;
  final String? titleNe;
  final String? summaryEn;
  final String? summaryNe;
  final String? bodyEn;
  final String? bodyNe;
  final String? sourceName;
  final String? sourceUrl;
  final String? externalUrl;
  final int? coverMediaId;
  final String? coverMediaUrl;
  final String status;
  final DateTime? publishedAt;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  const NewsItem({
    required this.id,
    required this.slug,
    this.titleEn,
    this.titleNe,
    this.summaryEn,
    this.summaryNe,
    this.bodyEn,
    this.bodyNe,
    this.sourceName,
    this.sourceUrl,
    this.externalUrl,
    this.coverMediaId,
    this.coverMediaUrl,
    required this.status,
    this.publishedAt,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['slug'] = Variable<String>(slug);
    if (!nullToAbsent || titleEn != null) {
      map['title_en'] = Variable<String>(titleEn);
    }
    if (!nullToAbsent || titleNe != null) {
      map['title_ne'] = Variable<String>(titleNe);
    }
    if (!nullToAbsent || summaryEn != null) {
      map['summary_en'] = Variable<String>(summaryEn);
    }
    if (!nullToAbsent || summaryNe != null) {
      map['summary_ne'] = Variable<String>(summaryNe);
    }
    if (!nullToAbsent || bodyEn != null) {
      map['body_en'] = Variable<String>(bodyEn);
    }
    if (!nullToAbsent || bodyNe != null) {
      map['body_ne'] = Variable<String>(bodyNe);
    }
    if (!nullToAbsent || sourceName != null) {
      map['source_name'] = Variable<String>(sourceName);
    }
    if (!nullToAbsent || sourceUrl != null) {
      map['source_url'] = Variable<String>(sourceUrl);
    }
    if (!nullToAbsent || externalUrl != null) {
      map['external_url'] = Variable<String>(externalUrl);
    }
    if (!nullToAbsent || coverMediaId != null) {
      map['cover_media_id'] = Variable<int>(coverMediaId);
    }
    if (!nullToAbsent || coverMediaUrl != null) {
      map['cover_media_url'] = Variable<String>(coverMediaUrl);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || publishedAt != null) {
      map['published_at'] = Variable<DateTime>(publishedAt);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NewsItemsCompanion toCompanion(bool nullToAbsent) {
    return NewsItemsCompanion(
      id: Value(id),
      slug: Value(slug),
      titleEn: titleEn == null && nullToAbsent
          ? const Value.absent()
          : Value(titleEn),
      titleNe: titleNe == null && nullToAbsent
          ? const Value.absent()
          : Value(titleNe),
      summaryEn: summaryEn == null && nullToAbsent
          ? const Value.absent()
          : Value(summaryEn),
      summaryNe: summaryNe == null && nullToAbsent
          ? const Value.absent()
          : Value(summaryNe),
      bodyEn: bodyEn == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyEn),
      bodyNe: bodyNe == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyNe),
      sourceName: sourceName == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceName),
      sourceUrl: sourceUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceUrl),
      externalUrl: externalUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(externalUrl),
      coverMediaId: coverMediaId == null && nullToAbsent
          ? const Value.absent()
          : Value(coverMediaId),
      coverMediaUrl: coverMediaUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(coverMediaUrl),
      status: Value(status),
      publishedAt: publishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAt),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory NewsItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NewsItem(
      id: serializer.fromJson<int>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      titleEn: serializer.fromJson<String?>(json['titleEn']),
      titleNe: serializer.fromJson<String?>(json['titleNe']),
      summaryEn: serializer.fromJson<String?>(json['summaryEn']),
      summaryNe: serializer.fromJson<String?>(json['summaryNe']),
      bodyEn: serializer.fromJson<String?>(json['bodyEn']),
      bodyNe: serializer.fromJson<String?>(json['bodyNe']),
      sourceName: serializer.fromJson<String?>(json['sourceName']),
      sourceUrl: serializer.fromJson<String?>(json['sourceUrl']),
      externalUrl: serializer.fromJson<String?>(json['externalUrl']),
      coverMediaId: serializer.fromJson<int?>(json['coverMediaId']),
      coverMediaUrl: serializer.fromJson<String?>(json['coverMediaUrl']),
      status: serializer.fromJson<String>(json['status']),
      publishedAt: serializer.fromJson<DateTime?>(json['publishedAt']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'slug': serializer.toJson<String>(slug),
      'titleEn': serializer.toJson<String?>(titleEn),
      'titleNe': serializer.toJson<String?>(titleNe),
      'summaryEn': serializer.toJson<String?>(summaryEn),
      'summaryNe': serializer.toJson<String?>(summaryNe),
      'bodyEn': serializer.toJson<String?>(bodyEn),
      'bodyNe': serializer.toJson<String?>(bodyNe),
      'sourceName': serializer.toJson<String?>(sourceName),
      'sourceUrl': serializer.toJson<String?>(sourceUrl),
      'externalUrl': serializer.toJson<String?>(externalUrl),
      'coverMediaId': serializer.toJson<int?>(coverMediaId),
      'coverMediaUrl': serializer.toJson<String?>(coverMediaUrl),
      'status': serializer.toJson<String>(status),
      'publishedAt': serializer.toJson<DateTime?>(publishedAt),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NewsItem copyWith({
    int? id,
    String? slug,
    Value<String?> titleEn = const Value.absent(),
    Value<String?> titleNe = const Value.absent(),
    Value<String?> summaryEn = const Value.absent(),
    Value<String?> summaryNe = const Value.absent(),
    Value<String?> bodyEn = const Value.absent(),
    Value<String?> bodyNe = const Value.absent(),
    Value<String?> sourceName = const Value.absent(),
    Value<String?> sourceUrl = const Value.absent(),
    Value<String?> externalUrl = const Value.absent(),
    Value<int?> coverMediaId = const Value.absent(),
    Value<String?> coverMediaUrl = const Value.absent(),
    String? status,
    Value<DateTime?> publishedAt = const Value.absent(),
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => NewsItem(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    titleEn: titleEn.present ? titleEn.value : this.titleEn,
    titleNe: titleNe.present ? titleNe.value : this.titleNe,
    summaryEn: summaryEn.present ? summaryEn.value : this.summaryEn,
    summaryNe: summaryNe.present ? summaryNe.value : this.summaryNe,
    bodyEn: bodyEn.present ? bodyEn.value : this.bodyEn,
    bodyNe: bodyNe.present ? bodyNe.value : this.bodyNe,
    sourceName: sourceName.present ? sourceName.value : this.sourceName,
    sourceUrl: sourceUrl.present ? sourceUrl.value : this.sourceUrl,
    externalUrl: externalUrl.present ? externalUrl.value : this.externalUrl,
    coverMediaId: coverMediaId.present ? coverMediaId.value : this.coverMediaId,
    coverMediaUrl: coverMediaUrl.present
        ? coverMediaUrl.value
        : this.coverMediaUrl,
    status: status ?? this.status,
    publishedAt: publishedAt.present ? publishedAt.value : this.publishedAt,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NewsItem copyWithCompanion(NewsItemsCompanion data) {
    return NewsItem(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      titleEn: data.titleEn.present ? data.titleEn.value : this.titleEn,
      titleNe: data.titleNe.present ? data.titleNe.value : this.titleNe,
      summaryEn: data.summaryEn.present ? data.summaryEn.value : this.summaryEn,
      summaryNe: data.summaryNe.present ? data.summaryNe.value : this.summaryNe,
      bodyEn: data.bodyEn.present ? data.bodyEn.value : this.bodyEn,
      bodyNe: data.bodyNe.present ? data.bodyNe.value : this.bodyNe,
      sourceName: data.sourceName.present
          ? data.sourceName.value
          : this.sourceName,
      sourceUrl: data.sourceUrl.present ? data.sourceUrl.value : this.sourceUrl,
      externalUrl: data.externalUrl.present
          ? data.externalUrl.value
          : this.externalUrl,
      coverMediaId: data.coverMediaId.present
          ? data.coverMediaId.value
          : this.coverMediaId,
      coverMediaUrl: data.coverMediaUrl.present
          ? data.coverMediaUrl.value
          : this.coverMediaUrl,
      status: data.status.present ? data.status.value : this.status,
      publishedAt: data.publishedAt.present
          ? data.publishedAt.value
          : this.publishedAt,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NewsItem(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('titleEn: $titleEn, ')
          ..write('titleNe: $titleNe, ')
          ..write('summaryEn: $summaryEn, ')
          ..write('summaryNe: $summaryNe, ')
          ..write('bodyEn: $bodyEn, ')
          ..write('bodyNe: $bodyNe, ')
          ..write('sourceName: $sourceName, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('externalUrl: $externalUrl, ')
          ..write('coverMediaId: $coverMediaId, ')
          ..write('coverMediaUrl: $coverMediaUrl, ')
          ..write('status: $status, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    slug,
    titleEn,
    titleNe,
    summaryEn,
    summaryNe,
    bodyEn,
    bodyNe,
    sourceName,
    sourceUrl,
    externalUrl,
    coverMediaId,
    coverMediaUrl,
    status,
    publishedAt,
    sortOrder,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NewsItem &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.titleEn == this.titleEn &&
          other.titleNe == this.titleNe &&
          other.summaryEn == this.summaryEn &&
          other.summaryNe == this.summaryNe &&
          other.bodyEn == this.bodyEn &&
          other.bodyNe == this.bodyNe &&
          other.sourceName == this.sourceName &&
          other.sourceUrl == this.sourceUrl &&
          other.externalUrl == this.externalUrl &&
          other.coverMediaId == this.coverMediaId &&
          other.coverMediaUrl == this.coverMediaUrl &&
          other.status == this.status &&
          other.publishedAt == this.publishedAt &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NewsItemsCompanion extends UpdateCompanion<NewsItem> {
  final Value<int> id;
  final Value<String> slug;
  final Value<String?> titleEn;
  final Value<String?> titleNe;
  final Value<String?> summaryEn;
  final Value<String?> summaryNe;
  final Value<String?> bodyEn;
  final Value<String?> bodyNe;
  final Value<String?> sourceName;
  final Value<String?> sourceUrl;
  final Value<String?> externalUrl;
  final Value<int?> coverMediaId;
  final Value<String?> coverMediaUrl;
  final Value<String> status;
  final Value<DateTime?> publishedAt;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const NewsItemsCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.titleEn = const Value.absent(),
    this.titleNe = const Value.absent(),
    this.summaryEn = const Value.absent(),
    this.summaryNe = const Value.absent(),
    this.bodyEn = const Value.absent(),
    this.bodyNe = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.sourceUrl = const Value.absent(),
    this.externalUrl = const Value.absent(),
    this.coverMediaId = const Value.absent(),
    this.coverMediaUrl = const Value.absent(),
    this.status = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  NewsItemsCompanion.insert({
    this.id = const Value.absent(),
    required String slug,
    this.titleEn = const Value.absent(),
    this.titleNe = const Value.absent(),
    this.summaryEn = const Value.absent(),
    this.summaryNe = const Value.absent(),
    this.bodyEn = const Value.absent(),
    this.bodyNe = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.sourceUrl = const Value.absent(),
    this.externalUrl = const Value.absent(),
    this.coverMediaId = const Value.absent(),
    this.coverMediaUrl = const Value.absent(),
    required String status,
    this.publishedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : slug = Value(slug),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<NewsItem> custom({
    Expression<int>? id,
    Expression<String>? slug,
    Expression<String>? titleEn,
    Expression<String>? titleNe,
    Expression<String>? summaryEn,
    Expression<String>? summaryNe,
    Expression<String>? bodyEn,
    Expression<String>? bodyNe,
    Expression<String>? sourceName,
    Expression<String>? sourceUrl,
    Expression<String>? externalUrl,
    Expression<int>? coverMediaId,
    Expression<String>? coverMediaUrl,
    Expression<String>? status,
    Expression<DateTime>? publishedAt,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (titleEn != null) 'title_en': titleEn,
      if (titleNe != null) 'title_ne': titleNe,
      if (summaryEn != null) 'summary_en': summaryEn,
      if (summaryNe != null) 'summary_ne': summaryNe,
      if (bodyEn != null) 'body_en': bodyEn,
      if (bodyNe != null) 'body_ne': bodyNe,
      if (sourceName != null) 'source_name': sourceName,
      if (sourceUrl != null) 'source_url': sourceUrl,
      if (externalUrl != null) 'external_url': externalUrl,
      if (coverMediaId != null) 'cover_media_id': coverMediaId,
      if (coverMediaUrl != null) 'cover_media_url': coverMediaUrl,
      if (status != null) 'status': status,
      if (publishedAt != null) 'published_at': publishedAt,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  NewsItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? slug,
    Value<String?>? titleEn,
    Value<String?>? titleNe,
    Value<String?>? summaryEn,
    Value<String?>? summaryNe,
    Value<String?>? bodyEn,
    Value<String?>? bodyNe,
    Value<String?>? sourceName,
    Value<String?>? sourceUrl,
    Value<String?>? externalUrl,
    Value<int?>? coverMediaId,
    Value<String?>? coverMediaUrl,
    Value<String>? status,
    Value<DateTime?>? publishedAt,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return NewsItemsCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      titleEn: titleEn ?? this.titleEn,
      titleNe: titleNe ?? this.titleNe,
      summaryEn: summaryEn ?? this.summaryEn,
      summaryNe: summaryNe ?? this.summaryNe,
      bodyEn: bodyEn ?? this.bodyEn,
      bodyNe: bodyNe ?? this.bodyNe,
      sourceName: sourceName ?? this.sourceName,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      externalUrl: externalUrl ?? this.externalUrl,
      coverMediaId: coverMediaId ?? this.coverMediaId,
      coverMediaUrl: coverMediaUrl ?? this.coverMediaUrl,
      status: status ?? this.status,
      publishedAt: publishedAt ?? this.publishedAt,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (titleEn.present) {
      map['title_en'] = Variable<String>(titleEn.value);
    }
    if (titleNe.present) {
      map['title_ne'] = Variable<String>(titleNe.value);
    }
    if (summaryEn.present) {
      map['summary_en'] = Variable<String>(summaryEn.value);
    }
    if (summaryNe.present) {
      map['summary_ne'] = Variable<String>(summaryNe.value);
    }
    if (bodyEn.present) {
      map['body_en'] = Variable<String>(bodyEn.value);
    }
    if (bodyNe.present) {
      map['body_ne'] = Variable<String>(bodyNe.value);
    }
    if (sourceName.present) {
      map['source_name'] = Variable<String>(sourceName.value);
    }
    if (sourceUrl.present) {
      map['source_url'] = Variable<String>(sourceUrl.value);
    }
    if (externalUrl.present) {
      map['external_url'] = Variable<String>(externalUrl.value);
    }
    if (coverMediaId.present) {
      map['cover_media_id'] = Variable<int>(coverMediaId.value);
    }
    if (coverMediaUrl.present) {
      map['cover_media_url'] = Variable<String>(coverMediaUrl.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NewsItemsCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('titleEn: $titleEn, ')
          ..write('titleNe: $titleNe, ')
          ..write('summaryEn: $summaryEn, ')
          ..write('summaryNe: $summaryNe, ')
          ..write('bodyEn: $bodyEn, ')
          ..write('bodyNe: $bodyNe, ')
          ..write('sourceName: $sourceName, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('externalUrl: $externalUrl, ')
          ..write('coverMediaId: $coverMediaId, ')
          ..write('coverMediaUrl: $coverMediaUrl, ')
          ..write('status: $status, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $StatisticsTable extends Statistics
    with TableInfo<$StatisticsTable, Statistic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatisticsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _districtIdMeta = const VerificationMeta(
    'districtId',
  );
  @override
  late final GeneratedColumn<int> districtId = GeneratedColumn<int>(
    'district_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seasonYearMeta = const VerificationMeta(
    'seasonYear',
  );
  @override
  late final GeneratedColumn<int> seasonYear = GeneratedColumn<int>(
    'season_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekNumberMeta = const VerificationMeta(
    'weekNumber',
  );
  @override
  late final GeneratedColumn<int> weekNumber = GeneratedColumn<int>(
    'week_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _caseCountMeta = const VerificationMeta(
    'caseCount',
  );
  @override
  late final GeneratedColumn<int> caseCount = GeneratedColumn<int>(
    'case_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reportedAtMeta = const VerificationMeta(
    'reportedAt',
  );
  @override
  late final GeneratedColumn<String> reportedAt = GeneratedColumn<String>(
    'reported_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesEnMeta = const VerificationMeta(
    'notesEn',
  );
  @override
  late final GeneratedColumn<String> notesEn = GeneratedColumn<String>(
    'notes_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesNeMeta = const VerificationMeta(
    'notesNe',
  );
  @override
  late final GeneratedColumn<String> notesNe = GeneratedColumn<String>(
    'notes_ne',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    districtId,
    seasonYear,
    weekNumber,
    caseCount,
    reportedAt,
    notesEn,
    notesNe,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'statistics';
  @override
  VerificationContext validateIntegrity(
    Insertable<Statistic> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('district_id')) {
      context.handle(
        _districtIdMeta,
        districtId.isAcceptableOrUnknown(data['district_id']!, _districtIdMeta),
      );
    } else if (isInserting) {
      context.missing(_districtIdMeta);
    }
    if (data.containsKey('season_year')) {
      context.handle(
        _seasonYearMeta,
        seasonYear.isAcceptableOrUnknown(data['season_year']!, _seasonYearMeta),
      );
    } else if (isInserting) {
      context.missing(_seasonYearMeta);
    }
    if (data.containsKey('week_number')) {
      context.handle(
        _weekNumberMeta,
        weekNumber.isAcceptableOrUnknown(data['week_number']!, _weekNumberMeta),
      );
    }
    if (data.containsKey('case_count')) {
      context.handle(
        _caseCountMeta,
        caseCount.isAcceptableOrUnknown(data['case_count']!, _caseCountMeta),
      );
    } else if (isInserting) {
      context.missing(_caseCountMeta);
    }
    if (data.containsKey('reported_at')) {
      context.handle(
        _reportedAtMeta,
        reportedAt.isAcceptableOrUnknown(data['reported_at']!, _reportedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_reportedAtMeta);
    }
    if (data.containsKey('notes_en')) {
      context.handle(
        _notesEnMeta,
        notesEn.isAcceptableOrUnknown(data['notes_en']!, _notesEnMeta),
      );
    }
    if (data.containsKey('notes_ne')) {
      context.handle(
        _notesNeMeta,
        notesNe.isAcceptableOrUnknown(data['notes_ne']!, _notesNeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Statistic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Statistic(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      districtId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}district_id'],
      )!,
      seasonYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}season_year'],
      )!,
      weekNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week_number'],
      ),
      caseCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}case_count'],
      )!,
      reportedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reported_at'],
      )!,
      notesEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes_en'],
      ),
      notesNe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes_ne'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StatisticsTable createAlias(String alias) {
    return $StatisticsTable(attachedDatabase, alias);
  }
}

class Statistic extends DataClass implements Insertable<Statistic> {
  final int id;
  final int districtId;
  final int seasonYear;
  final int? weekNumber;
  final int caseCount;
  final String reportedAt;
  final String? notesEn;
  final String? notesNe;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Statistic({
    required this.id,
    required this.districtId,
    required this.seasonYear,
    this.weekNumber,
    required this.caseCount,
    required this.reportedAt,
    this.notesEn,
    this.notesNe,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['district_id'] = Variable<int>(districtId);
    map['season_year'] = Variable<int>(seasonYear);
    if (!nullToAbsent || weekNumber != null) {
      map['week_number'] = Variable<int>(weekNumber);
    }
    map['case_count'] = Variable<int>(caseCount);
    map['reported_at'] = Variable<String>(reportedAt);
    if (!nullToAbsent || notesEn != null) {
      map['notes_en'] = Variable<String>(notesEn);
    }
    if (!nullToAbsent || notesNe != null) {
      map['notes_ne'] = Variable<String>(notesNe);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StatisticsCompanion toCompanion(bool nullToAbsent) {
    return StatisticsCompanion(
      id: Value(id),
      districtId: Value(districtId),
      seasonYear: Value(seasonYear),
      weekNumber: weekNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(weekNumber),
      caseCount: Value(caseCount),
      reportedAt: Value(reportedAt),
      notesEn: notesEn == null && nullToAbsent
          ? const Value.absent()
          : Value(notesEn),
      notesNe: notesNe == null && nullToAbsent
          ? const Value.absent()
          : Value(notesNe),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Statistic.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Statistic(
      id: serializer.fromJson<int>(json['id']),
      districtId: serializer.fromJson<int>(json['districtId']),
      seasonYear: serializer.fromJson<int>(json['seasonYear']),
      weekNumber: serializer.fromJson<int?>(json['weekNumber']),
      caseCount: serializer.fromJson<int>(json['caseCount']),
      reportedAt: serializer.fromJson<String>(json['reportedAt']),
      notesEn: serializer.fromJson<String?>(json['notesEn']),
      notesNe: serializer.fromJson<String?>(json['notesNe']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'districtId': serializer.toJson<int>(districtId),
      'seasonYear': serializer.toJson<int>(seasonYear),
      'weekNumber': serializer.toJson<int?>(weekNumber),
      'caseCount': serializer.toJson<int>(caseCount),
      'reportedAt': serializer.toJson<String>(reportedAt),
      'notesEn': serializer.toJson<String?>(notesEn),
      'notesNe': serializer.toJson<String?>(notesNe),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Statistic copyWith({
    int? id,
    int? districtId,
    int? seasonYear,
    Value<int?> weekNumber = const Value.absent(),
    int? caseCount,
    String? reportedAt,
    Value<String?> notesEn = const Value.absent(),
    Value<String?> notesNe = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Statistic(
    id: id ?? this.id,
    districtId: districtId ?? this.districtId,
    seasonYear: seasonYear ?? this.seasonYear,
    weekNumber: weekNumber.present ? weekNumber.value : this.weekNumber,
    caseCount: caseCount ?? this.caseCount,
    reportedAt: reportedAt ?? this.reportedAt,
    notesEn: notesEn.present ? notesEn.value : this.notesEn,
    notesNe: notesNe.present ? notesNe.value : this.notesNe,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Statistic copyWithCompanion(StatisticsCompanion data) {
    return Statistic(
      id: data.id.present ? data.id.value : this.id,
      districtId: data.districtId.present
          ? data.districtId.value
          : this.districtId,
      seasonYear: data.seasonYear.present
          ? data.seasonYear.value
          : this.seasonYear,
      weekNumber: data.weekNumber.present
          ? data.weekNumber.value
          : this.weekNumber,
      caseCount: data.caseCount.present ? data.caseCount.value : this.caseCount,
      reportedAt: data.reportedAt.present
          ? data.reportedAt.value
          : this.reportedAt,
      notesEn: data.notesEn.present ? data.notesEn.value : this.notesEn,
      notesNe: data.notesNe.present ? data.notesNe.value : this.notesNe,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Statistic(')
          ..write('id: $id, ')
          ..write('districtId: $districtId, ')
          ..write('seasonYear: $seasonYear, ')
          ..write('weekNumber: $weekNumber, ')
          ..write('caseCount: $caseCount, ')
          ..write('reportedAt: $reportedAt, ')
          ..write('notesEn: $notesEn, ')
          ..write('notesNe: $notesNe, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    districtId,
    seasonYear,
    weekNumber,
    caseCount,
    reportedAt,
    notesEn,
    notesNe,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Statistic &&
          other.id == this.id &&
          other.districtId == this.districtId &&
          other.seasonYear == this.seasonYear &&
          other.weekNumber == this.weekNumber &&
          other.caseCount == this.caseCount &&
          other.reportedAt == this.reportedAt &&
          other.notesEn == this.notesEn &&
          other.notesNe == this.notesNe &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StatisticsCompanion extends UpdateCompanion<Statistic> {
  final Value<int> id;
  final Value<int> districtId;
  final Value<int> seasonYear;
  final Value<int?> weekNumber;
  final Value<int> caseCount;
  final Value<String> reportedAt;
  final Value<String?> notesEn;
  final Value<String?> notesNe;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const StatisticsCompanion({
    this.id = const Value.absent(),
    this.districtId = const Value.absent(),
    this.seasonYear = const Value.absent(),
    this.weekNumber = const Value.absent(),
    this.caseCount = const Value.absent(),
    this.reportedAt = const Value.absent(),
    this.notesEn = const Value.absent(),
    this.notesNe = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StatisticsCompanion.insert({
    this.id = const Value.absent(),
    required int districtId,
    required int seasonYear,
    this.weekNumber = const Value.absent(),
    required int caseCount,
    required String reportedAt,
    this.notesEn = const Value.absent(),
    this.notesNe = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : districtId = Value(districtId),
       seasonYear = Value(seasonYear),
       caseCount = Value(caseCount),
       reportedAt = Value(reportedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Statistic> custom({
    Expression<int>? id,
    Expression<int>? districtId,
    Expression<int>? seasonYear,
    Expression<int>? weekNumber,
    Expression<int>? caseCount,
    Expression<String>? reportedAt,
    Expression<String>? notesEn,
    Expression<String>? notesNe,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (districtId != null) 'district_id': districtId,
      if (seasonYear != null) 'season_year': seasonYear,
      if (weekNumber != null) 'week_number': weekNumber,
      if (caseCount != null) 'case_count': caseCount,
      if (reportedAt != null) 'reported_at': reportedAt,
      if (notesEn != null) 'notes_en': notesEn,
      if (notesNe != null) 'notes_ne': notesNe,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StatisticsCompanion copyWith({
    Value<int>? id,
    Value<int>? districtId,
    Value<int>? seasonYear,
    Value<int?>? weekNumber,
    Value<int>? caseCount,
    Value<String>? reportedAt,
    Value<String?>? notesEn,
    Value<String?>? notesNe,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return StatisticsCompanion(
      id: id ?? this.id,
      districtId: districtId ?? this.districtId,
      seasonYear: seasonYear ?? this.seasonYear,
      weekNumber: weekNumber ?? this.weekNumber,
      caseCount: caseCount ?? this.caseCount,
      reportedAt: reportedAt ?? this.reportedAt,
      notesEn: notesEn ?? this.notesEn,
      notesNe: notesNe ?? this.notesNe,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (districtId.present) {
      map['district_id'] = Variable<int>(districtId.value);
    }
    if (seasonYear.present) {
      map['season_year'] = Variable<int>(seasonYear.value);
    }
    if (weekNumber.present) {
      map['week_number'] = Variable<int>(weekNumber.value);
    }
    if (caseCount.present) {
      map['case_count'] = Variable<int>(caseCount.value);
    }
    if (reportedAt.present) {
      map['reported_at'] = Variable<String>(reportedAt.value);
    }
    if (notesEn.present) {
      map['notes_en'] = Variable<String>(notesEn.value);
    }
    if (notesNe.present) {
      map['notes_ne'] = Variable<String>(notesNe.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatisticsCompanion(')
          ..write('id: $id, ')
          ..write('districtId: $districtId, ')
          ..write('seasonYear: $seasonYear, ')
          ..write('weekNumber: $weekNumber, ')
          ..write('caseCount: $caseCount, ')
          ..write('reportedAt: $reportedAt, ')
          ..write('notesEn: $notesEn, ')
          ..write('notesNe: $notesNe, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts with TableInfo<$ContactsTable, Contact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameNeMeta = const VerificationMeta('nameNe');
  @override
  late final GeneratedColumn<String> nameNe = GeneratedColumn<String>(
    'name_ne',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _districtIdMeta = const VerificationMeta(
    'districtId',
  );
  @override
  late final GeneratedColumn<int> districtId = GeneratedColumn<int>(
    'district_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactTypeMeta = const VerificationMeta(
    'contactType',
  );
  @override
  late final GeneratedColumn<String> contactType = GeneratedColumn<String>(
    'contact_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameEn,
    nameNe,
    phone,
    districtId,
    contactType,
    isActive,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Contact> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    }
    if (data.containsKey('name_ne')) {
      context.handle(
        _nameNeMeta,
        nameNe.isAcceptableOrUnknown(data['name_ne']!, _nameNeMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('district_id')) {
      context.handle(
        _districtIdMeta,
        districtId.isAcceptableOrUnknown(data['district_id']!, _districtIdMeta),
      );
    }
    if (data.containsKey('contact_type')) {
      context.handle(
        _contactTypeMeta,
        contactType.isAcceptableOrUnknown(
          data['contact_type']!,
          _contactTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contactTypeMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contact(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      ),
      nameNe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ne'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      districtId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}district_id'],
      ),
      contactType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_type'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }
}

class Contact extends DataClass implements Insertable<Contact> {
  final int id;
  final String? nameEn;
  final String? nameNe;
  final String phone;
  final int? districtId;
  final String contactType;
  final bool isActive;
  final int sortOrder;
  const Contact({
    required this.id,
    this.nameEn,
    this.nameNe,
    required this.phone,
    this.districtId,
    required this.contactType,
    required this.isActive,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    if (!nullToAbsent || nameNe != null) {
      map['name_ne'] = Variable<String>(nameNe);
    }
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || districtId != null) {
      map['district_id'] = Variable<int>(districtId);
    }
    map['contact_type'] = Variable<String>(contactType);
    map['is_active'] = Variable<bool>(isActive);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      id: Value(id),
      nameEn: nameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEn),
      nameNe: nameNe == null && nullToAbsent
          ? const Value.absent()
          : Value(nameNe),
      phone: Value(phone),
      districtId: districtId == null && nullToAbsent
          ? const Value.absent()
          : Value(districtId),
      contactType: Value(contactType),
      isActive: Value(isActive),
      sortOrder: Value(sortOrder),
    );
  }

  factory Contact.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contact(
      id: serializer.fromJson<int>(json['id']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      nameNe: serializer.fromJson<String?>(json['nameNe']),
      phone: serializer.fromJson<String>(json['phone']),
      districtId: serializer.fromJson<int?>(json['districtId']),
      contactType: serializer.fromJson<String>(json['contactType']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameEn': serializer.toJson<String?>(nameEn),
      'nameNe': serializer.toJson<String?>(nameNe),
      'phone': serializer.toJson<String>(phone),
      'districtId': serializer.toJson<int?>(districtId),
      'contactType': serializer.toJson<String>(contactType),
      'isActive': serializer.toJson<bool>(isActive),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Contact copyWith({
    int? id,
    Value<String?> nameEn = const Value.absent(),
    Value<String?> nameNe = const Value.absent(),
    String? phone,
    Value<int?> districtId = const Value.absent(),
    String? contactType,
    bool? isActive,
    int? sortOrder,
  }) => Contact(
    id: id ?? this.id,
    nameEn: nameEn.present ? nameEn.value : this.nameEn,
    nameNe: nameNe.present ? nameNe.value : this.nameNe,
    phone: phone ?? this.phone,
    districtId: districtId.present ? districtId.value : this.districtId,
    contactType: contactType ?? this.contactType,
    isActive: isActive ?? this.isActive,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Contact copyWithCompanion(ContactsCompanion data) {
    return Contact(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameNe: data.nameNe.present ? data.nameNe.value : this.nameNe,
      phone: data.phone.present ? data.phone.value : this.phone,
      districtId: data.districtId.present
          ? data.districtId.value
          : this.districtId,
      contactType: data.contactType.present
          ? data.contactType.value
          : this.contactType,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contact(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameNe: $nameNe, ')
          ..write('phone: $phone, ')
          ..write('districtId: $districtId, ')
          ..write('contactType: $contactType, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nameEn,
    nameNe,
    phone,
    districtId,
    contactType,
    isActive,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contact &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameNe == this.nameNe &&
          other.phone == this.phone &&
          other.districtId == this.districtId &&
          other.contactType == this.contactType &&
          other.isActive == this.isActive &&
          other.sortOrder == this.sortOrder);
}

class ContactsCompanion extends UpdateCompanion<Contact> {
  final Value<int> id;
  final Value<String?> nameEn;
  final Value<String?> nameNe;
  final Value<String> phone;
  final Value<int?> districtId;
  final Value<String> contactType;
  final Value<bool> isActive;
  final Value<int> sortOrder;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameNe = const Value.absent(),
    this.phone = const Value.absent(),
    this.districtId = const Value.absent(),
    this.contactType = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  ContactsCompanion.insert({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameNe = const Value.absent(),
    required String phone,
    this.districtId = const Value.absent(),
    required String contactType,
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
  }) : phone = Value(phone),
       contactType = Value(contactType);
  static Insertable<Contact> custom({
    Expression<int>? id,
    Expression<String>? nameEn,
    Expression<String>? nameNe,
    Expression<String>? phone,
    Expression<int>? districtId,
    Expression<String>? contactType,
    Expression<bool>? isActive,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameNe != null) 'name_ne': nameNe,
      if (phone != null) 'phone': phone,
      if (districtId != null) 'district_id': districtId,
      if (contactType != null) 'contact_type': contactType,
      if (isActive != null) 'is_active': isActive,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  ContactsCompanion copyWith({
    Value<int>? id,
    Value<String?>? nameEn,
    Value<String?>? nameNe,
    Value<String>? phone,
    Value<int?>? districtId,
    Value<String>? contactType,
    Value<bool>? isActive,
    Value<int>? sortOrder,
  }) {
    return ContactsCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameNe: nameNe ?? this.nameNe,
      phone: phone ?? this.phone,
      districtId: districtId ?? this.districtId,
      contactType: contactType ?? this.contactType,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameNe.present) {
      map['name_ne'] = Variable<String>(nameNe.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (districtId.present) {
      map['district_id'] = Variable<int>(districtId.value);
    }
    if (contactType.present) {
      map['contact_type'] = Variable<String>(contactType.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameNe: $nameNe, ')
          ..write('phone: $phone, ')
          ..write('districtId: $districtId, ')
          ..write('contactType: $contactType, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SyncMetadataTable syncMetadata = $SyncMetadataTable(this);
  late final $DistrictsTable districts = $DistrictsTable(this);
  late final $ArticlesTable articles = $ArticlesTable(this);
  late final $NewsItemsTable newsItems = $NewsItemsTable(this);
  late final $StatisticsTable statistics = $StatisticsTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    syncMetadata,
    districts,
    articles,
    newsItems,
    statistics,
    contacts,
  ];
}

typedef $$SyncMetadataTableCreateCompanionBuilder =
    SyncMetadataCompanion Function({
      required String key,
      required DateTime lastSyncedAt,
      Value<int> rowid,
    });
typedef $$SyncMetadataTableUpdateCompanionBuilder =
    SyncMetadataCompanion Function({
      Value<String> key,
      Value<DateTime> lastSyncedAt,
      Value<int> rowid,
    });

class $$SyncMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$SyncMetadataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncMetadataTable,
          SyncMetadataData,
          $$SyncMetadataTableFilterComposer,
          $$SyncMetadataTableOrderingComposer,
          $$SyncMetadataTableAnnotationComposer,
          $$SyncMetadataTableCreateCompanionBuilder,
          $$SyncMetadataTableUpdateCompanionBuilder,
          (
            SyncMetadataData,
            BaseReferences<_$AppDatabase, $SyncMetadataTable, SyncMetadataData>,
          ),
          SyncMetadataData,
          PrefetchHooks Function()
        > {
  $$SyncMetadataTableTableManager(_$AppDatabase db, $SyncMetadataTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<DateTime> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataCompanion(
                key: key,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required DateTime lastSyncedAt,
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataCompanion.insert(
                key: key,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncMetadataTable,
      SyncMetadataData,
      $$SyncMetadataTableFilterComposer,
      $$SyncMetadataTableOrderingComposer,
      $$SyncMetadataTableAnnotationComposer,
      $$SyncMetadataTableCreateCompanionBuilder,
      $$SyncMetadataTableUpdateCompanionBuilder,
      (
        SyncMetadataData,
        BaseReferences<_$AppDatabase, $SyncMetadataTable, SyncMetadataData>,
      ),
      SyncMetadataData,
      PrefetchHooks Function()
    >;
typedef $$DistrictsTableCreateCompanionBuilder =
    DistrictsCompanion Function({
      Value<int> id,
      required String code,
      Value<String?> nameEn,
      Value<String?> nameNe,
      required String provinceEn,
      Value<double?> latitude,
      Value<double?> longitude,
    });
typedef $$DistrictsTableUpdateCompanionBuilder =
    DistrictsCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String?> nameEn,
      Value<String?> nameNe,
      Value<String> provinceEn,
      Value<double?> latitude,
      Value<double?> longitude,
    });

class $$DistrictsTableFilterComposer
    extends Composer<_$AppDatabase, $DistrictsTable> {
  $$DistrictsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameNe => $composableBuilder(
    column: $table.nameNe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provinceEn => $composableBuilder(
    column: $table.provinceEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DistrictsTableOrderingComposer
    extends Composer<_$AppDatabase, $DistrictsTable> {
  $$DistrictsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameNe => $composableBuilder(
    column: $table.nameNe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provinceEn => $composableBuilder(
    column: $table.provinceEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DistrictsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DistrictsTable> {
  $$DistrictsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameNe =>
      $composableBuilder(column: $table.nameNe, builder: (column) => column);

  GeneratedColumn<String> get provinceEn => $composableBuilder(
    column: $table.provinceEn,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);
}

class $$DistrictsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DistrictsTable,
          District,
          $$DistrictsTableFilterComposer,
          $$DistrictsTableOrderingComposer,
          $$DistrictsTableAnnotationComposer,
          $$DistrictsTableCreateCompanionBuilder,
          $$DistrictsTableUpdateCompanionBuilder,
          (District, BaseReferences<_$AppDatabase, $DistrictsTable, District>),
          District,
          PrefetchHooks Function()
        > {
  $$DistrictsTableTableManager(_$AppDatabase db, $DistrictsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DistrictsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DistrictsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DistrictsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> nameNe = const Value.absent(),
                Value<String> provinceEn = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
              }) => DistrictsCompanion(
                id: id,
                code: code,
                nameEn: nameEn,
                nameNe: nameNe,
                provinceEn: provinceEn,
                latitude: latitude,
                longitude: longitude,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                Value<String?> nameEn = const Value.absent(),
                Value<String?> nameNe = const Value.absent(),
                required String provinceEn,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
              }) => DistrictsCompanion.insert(
                id: id,
                code: code,
                nameEn: nameEn,
                nameNe: nameNe,
                provinceEn: provinceEn,
                latitude: latitude,
                longitude: longitude,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DistrictsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DistrictsTable,
      District,
      $$DistrictsTableFilterComposer,
      $$DistrictsTableOrderingComposer,
      $$DistrictsTableAnnotationComposer,
      $$DistrictsTableCreateCompanionBuilder,
      $$DistrictsTableUpdateCompanionBuilder,
      (District, BaseReferences<_$AppDatabase, $DistrictsTable, District>),
      District,
      PrefetchHooks Function()
    >;
typedef $$ArticlesTableCreateCompanionBuilder =
    ArticlesCompanion Function({
      Value<int> id,
      required String slug,
      Value<String?> titleEn,
      Value<String?> titleNe,
      Value<String?> summaryEn,
      Value<String?> summaryNe,
      Value<String?> bodyEn,
      Value<String?> bodyNe,
      Value<int?> coverMediaId,
      Value<String?> coverMediaUrl,
      required String status,
      Value<DateTime?> publishedAt,
      Value<int> sortOrder,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$ArticlesTableUpdateCompanionBuilder =
    ArticlesCompanion Function({
      Value<int> id,
      Value<String> slug,
      Value<String?> titleEn,
      Value<String?> titleNe,
      Value<String?> summaryEn,
      Value<String?> summaryNe,
      Value<String?> bodyEn,
      Value<String?> bodyNe,
      Value<int?> coverMediaId,
      Value<String?> coverMediaUrl,
      Value<String> status,
      Value<DateTime?> publishedAt,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$ArticlesTableFilterComposer
    extends Composer<_$AppDatabase, $ArticlesTable> {
  $$ArticlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleEn => $composableBuilder(
    column: $table.titleEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleNe => $composableBuilder(
    column: $table.titleNe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summaryEn => $composableBuilder(
    column: $table.summaryEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summaryNe => $composableBuilder(
    column: $table.summaryNe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyEn => $composableBuilder(
    column: $table.bodyEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyNe => $composableBuilder(
    column: $table.bodyNe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coverMediaId => $composableBuilder(
    column: $table.coverMediaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverMediaUrl => $composableBuilder(
    column: $table.coverMediaUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ArticlesTableOrderingComposer
    extends Composer<_$AppDatabase, $ArticlesTable> {
  $$ArticlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleEn => $composableBuilder(
    column: $table.titleEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleNe => $composableBuilder(
    column: $table.titleNe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summaryEn => $composableBuilder(
    column: $table.summaryEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summaryNe => $composableBuilder(
    column: $table.summaryNe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyEn => $composableBuilder(
    column: $table.bodyEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyNe => $composableBuilder(
    column: $table.bodyNe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coverMediaId => $composableBuilder(
    column: $table.coverMediaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverMediaUrl => $composableBuilder(
    column: $table.coverMediaUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ArticlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArticlesTable> {
  $$ArticlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get titleEn =>
      $composableBuilder(column: $table.titleEn, builder: (column) => column);

  GeneratedColumn<String> get titleNe =>
      $composableBuilder(column: $table.titleNe, builder: (column) => column);

  GeneratedColumn<String> get summaryEn =>
      $composableBuilder(column: $table.summaryEn, builder: (column) => column);

  GeneratedColumn<String> get summaryNe =>
      $composableBuilder(column: $table.summaryNe, builder: (column) => column);

  GeneratedColumn<String> get bodyEn =>
      $composableBuilder(column: $table.bodyEn, builder: (column) => column);

  GeneratedColumn<String> get bodyNe =>
      $composableBuilder(column: $table.bodyNe, builder: (column) => column);

  GeneratedColumn<int> get coverMediaId => $composableBuilder(
    column: $table.coverMediaId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coverMediaUrl => $composableBuilder(
    column: $table.coverMediaUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ArticlesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ArticlesTable,
          Article,
          $$ArticlesTableFilterComposer,
          $$ArticlesTableOrderingComposer,
          $$ArticlesTableAnnotationComposer,
          $$ArticlesTableCreateCompanionBuilder,
          $$ArticlesTableUpdateCompanionBuilder,
          (Article, BaseReferences<_$AppDatabase, $ArticlesTable, Article>),
          Article,
          PrefetchHooks Function()
        > {
  $$ArticlesTableTableManager(_$AppDatabase db, $ArticlesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArticlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArticlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArticlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String?> titleEn = const Value.absent(),
                Value<String?> titleNe = const Value.absent(),
                Value<String?> summaryEn = const Value.absent(),
                Value<String?> summaryNe = const Value.absent(),
                Value<String?> bodyEn = const Value.absent(),
                Value<String?> bodyNe = const Value.absent(),
                Value<int?> coverMediaId = const Value.absent(),
                Value<String?> coverMediaUrl = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ArticlesCompanion(
                id: id,
                slug: slug,
                titleEn: titleEn,
                titleNe: titleNe,
                summaryEn: summaryEn,
                summaryNe: summaryNe,
                bodyEn: bodyEn,
                bodyNe: bodyNe,
                coverMediaId: coverMediaId,
                coverMediaUrl: coverMediaUrl,
                status: status,
                publishedAt: publishedAt,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String slug,
                Value<String?> titleEn = const Value.absent(),
                Value<String?> titleNe = const Value.absent(),
                Value<String?> summaryEn = const Value.absent(),
                Value<String?> summaryNe = const Value.absent(),
                Value<String?> bodyEn = const Value.absent(),
                Value<String?> bodyNe = const Value.absent(),
                Value<int?> coverMediaId = const Value.absent(),
                Value<String?> coverMediaUrl = const Value.absent(),
                required String status,
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => ArticlesCompanion.insert(
                id: id,
                slug: slug,
                titleEn: titleEn,
                titleNe: titleNe,
                summaryEn: summaryEn,
                summaryNe: summaryNe,
                bodyEn: bodyEn,
                bodyNe: bodyNe,
                coverMediaId: coverMediaId,
                coverMediaUrl: coverMediaUrl,
                status: status,
                publishedAt: publishedAt,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ArticlesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ArticlesTable,
      Article,
      $$ArticlesTableFilterComposer,
      $$ArticlesTableOrderingComposer,
      $$ArticlesTableAnnotationComposer,
      $$ArticlesTableCreateCompanionBuilder,
      $$ArticlesTableUpdateCompanionBuilder,
      (Article, BaseReferences<_$AppDatabase, $ArticlesTable, Article>),
      Article,
      PrefetchHooks Function()
    >;
typedef $$NewsItemsTableCreateCompanionBuilder =
    NewsItemsCompanion Function({
      Value<int> id,
      required String slug,
      Value<String?> titleEn,
      Value<String?> titleNe,
      Value<String?> summaryEn,
      Value<String?> summaryNe,
      Value<String?> bodyEn,
      Value<String?> bodyNe,
      Value<String?> sourceName,
      Value<String?> sourceUrl,
      Value<String?> externalUrl,
      Value<int?> coverMediaId,
      Value<String?> coverMediaUrl,
      required String status,
      Value<DateTime?> publishedAt,
      Value<int> sortOrder,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$NewsItemsTableUpdateCompanionBuilder =
    NewsItemsCompanion Function({
      Value<int> id,
      Value<String> slug,
      Value<String?> titleEn,
      Value<String?> titleNe,
      Value<String?> summaryEn,
      Value<String?> summaryNe,
      Value<String?> bodyEn,
      Value<String?> bodyNe,
      Value<String?> sourceName,
      Value<String?> sourceUrl,
      Value<String?> externalUrl,
      Value<int?> coverMediaId,
      Value<String?> coverMediaUrl,
      Value<String> status,
      Value<DateTime?> publishedAt,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$NewsItemsTableFilterComposer
    extends Composer<_$AppDatabase, $NewsItemsTable> {
  $$NewsItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleEn => $composableBuilder(
    column: $table.titleEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleNe => $composableBuilder(
    column: $table.titleNe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summaryEn => $composableBuilder(
    column: $table.summaryEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summaryNe => $composableBuilder(
    column: $table.summaryNe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyEn => $composableBuilder(
    column: $table.bodyEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyNe => $composableBuilder(
    column: $table.bodyNe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceUrl => $composableBuilder(
    column: $table.sourceUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalUrl => $composableBuilder(
    column: $table.externalUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coverMediaId => $composableBuilder(
    column: $table.coverMediaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverMediaUrl => $composableBuilder(
    column: $table.coverMediaUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NewsItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $NewsItemsTable> {
  $$NewsItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleEn => $composableBuilder(
    column: $table.titleEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleNe => $composableBuilder(
    column: $table.titleNe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summaryEn => $composableBuilder(
    column: $table.summaryEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summaryNe => $composableBuilder(
    column: $table.summaryNe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyEn => $composableBuilder(
    column: $table.bodyEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyNe => $composableBuilder(
    column: $table.bodyNe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceUrl => $composableBuilder(
    column: $table.sourceUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalUrl => $composableBuilder(
    column: $table.externalUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coverMediaId => $composableBuilder(
    column: $table.coverMediaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverMediaUrl => $composableBuilder(
    column: $table.coverMediaUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NewsItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NewsItemsTable> {
  $$NewsItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get titleEn =>
      $composableBuilder(column: $table.titleEn, builder: (column) => column);

  GeneratedColumn<String> get titleNe =>
      $composableBuilder(column: $table.titleNe, builder: (column) => column);

  GeneratedColumn<String> get summaryEn =>
      $composableBuilder(column: $table.summaryEn, builder: (column) => column);

  GeneratedColumn<String> get summaryNe =>
      $composableBuilder(column: $table.summaryNe, builder: (column) => column);

  GeneratedColumn<String> get bodyEn =>
      $composableBuilder(column: $table.bodyEn, builder: (column) => column);

  GeneratedColumn<String> get bodyNe =>
      $composableBuilder(column: $table.bodyNe, builder: (column) => column);

  GeneratedColumn<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceUrl =>
      $composableBuilder(column: $table.sourceUrl, builder: (column) => column);

  GeneratedColumn<String> get externalUrl => $composableBuilder(
    column: $table.externalUrl,
    builder: (column) => column,
  );

  GeneratedColumn<int> get coverMediaId => $composableBuilder(
    column: $table.coverMediaId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coverMediaUrl => $composableBuilder(
    column: $table.coverMediaUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NewsItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NewsItemsTable,
          NewsItem,
          $$NewsItemsTableFilterComposer,
          $$NewsItemsTableOrderingComposer,
          $$NewsItemsTableAnnotationComposer,
          $$NewsItemsTableCreateCompanionBuilder,
          $$NewsItemsTableUpdateCompanionBuilder,
          (NewsItem, BaseReferences<_$AppDatabase, $NewsItemsTable, NewsItem>),
          NewsItem,
          PrefetchHooks Function()
        > {
  $$NewsItemsTableTableManager(_$AppDatabase db, $NewsItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NewsItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NewsItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NewsItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String?> titleEn = const Value.absent(),
                Value<String?> titleNe = const Value.absent(),
                Value<String?> summaryEn = const Value.absent(),
                Value<String?> summaryNe = const Value.absent(),
                Value<String?> bodyEn = const Value.absent(),
                Value<String?> bodyNe = const Value.absent(),
                Value<String?> sourceName = const Value.absent(),
                Value<String?> sourceUrl = const Value.absent(),
                Value<String?> externalUrl = const Value.absent(),
                Value<int?> coverMediaId = const Value.absent(),
                Value<String?> coverMediaUrl = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => NewsItemsCompanion(
                id: id,
                slug: slug,
                titleEn: titleEn,
                titleNe: titleNe,
                summaryEn: summaryEn,
                summaryNe: summaryNe,
                bodyEn: bodyEn,
                bodyNe: bodyNe,
                sourceName: sourceName,
                sourceUrl: sourceUrl,
                externalUrl: externalUrl,
                coverMediaId: coverMediaId,
                coverMediaUrl: coverMediaUrl,
                status: status,
                publishedAt: publishedAt,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String slug,
                Value<String?> titleEn = const Value.absent(),
                Value<String?> titleNe = const Value.absent(),
                Value<String?> summaryEn = const Value.absent(),
                Value<String?> summaryNe = const Value.absent(),
                Value<String?> bodyEn = const Value.absent(),
                Value<String?> bodyNe = const Value.absent(),
                Value<String?> sourceName = const Value.absent(),
                Value<String?> sourceUrl = const Value.absent(),
                Value<String?> externalUrl = const Value.absent(),
                Value<int?> coverMediaId = const Value.absent(),
                Value<String?> coverMediaUrl = const Value.absent(),
                required String status,
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => NewsItemsCompanion.insert(
                id: id,
                slug: slug,
                titleEn: titleEn,
                titleNe: titleNe,
                summaryEn: summaryEn,
                summaryNe: summaryNe,
                bodyEn: bodyEn,
                bodyNe: bodyNe,
                sourceName: sourceName,
                sourceUrl: sourceUrl,
                externalUrl: externalUrl,
                coverMediaId: coverMediaId,
                coverMediaUrl: coverMediaUrl,
                status: status,
                publishedAt: publishedAt,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NewsItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NewsItemsTable,
      NewsItem,
      $$NewsItemsTableFilterComposer,
      $$NewsItemsTableOrderingComposer,
      $$NewsItemsTableAnnotationComposer,
      $$NewsItemsTableCreateCompanionBuilder,
      $$NewsItemsTableUpdateCompanionBuilder,
      (NewsItem, BaseReferences<_$AppDatabase, $NewsItemsTable, NewsItem>),
      NewsItem,
      PrefetchHooks Function()
    >;
typedef $$StatisticsTableCreateCompanionBuilder =
    StatisticsCompanion Function({
      Value<int> id,
      required int districtId,
      required int seasonYear,
      Value<int?> weekNumber,
      required int caseCount,
      required String reportedAt,
      Value<String?> notesEn,
      Value<String?> notesNe,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$StatisticsTableUpdateCompanionBuilder =
    StatisticsCompanion Function({
      Value<int> id,
      Value<int> districtId,
      Value<int> seasonYear,
      Value<int?> weekNumber,
      Value<int> caseCount,
      Value<String> reportedAt,
      Value<String?> notesEn,
      Value<String?> notesNe,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$StatisticsTableFilterComposer
    extends Composer<_$AppDatabase, $StatisticsTable> {
  $$StatisticsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get districtId => $composableBuilder(
    column: $table.districtId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seasonYear => $composableBuilder(
    column: $table.seasonYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekNumber => $composableBuilder(
    column: $table.weekNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get caseCount => $composableBuilder(
    column: $table.caseCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reportedAt => $composableBuilder(
    column: $table.reportedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notesEn => $composableBuilder(
    column: $table.notesEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notesNe => $composableBuilder(
    column: $table.notesNe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StatisticsTableOrderingComposer
    extends Composer<_$AppDatabase, $StatisticsTable> {
  $$StatisticsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get districtId => $composableBuilder(
    column: $table.districtId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seasonYear => $composableBuilder(
    column: $table.seasonYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekNumber => $composableBuilder(
    column: $table.weekNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get caseCount => $composableBuilder(
    column: $table.caseCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reportedAt => $composableBuilder(
    column: $table.reportedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notesEn => $composableBuilder(
    column: $table.notesEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notesNe => $composableBuilder(
    column: $table.notesNe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StatisticsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StatisticsTable> {
  $$StatisticsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get districtId => $composableBuilder(
    column: $table.districtId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get seasonYear => $composableBuilder(
    column: $table.seasonYear,
    builder: (column) => column,
  );

  GeneratedColumn<int> get weekNumber => $composableBuilder(
    column: $table.weekNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get caseCount =>
      $composableBuilder(column: $table.caseCount, builder: (column) => column);

  GeneratedColumn<String> get reportedAt => $composableBuilder(
    column: $table.reportedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notesEn =>
      $composableBuilder(column: $table.notesEn, builder: (column) => column);

  GeneratedColumn<String> get notesNe =>
      $composableBuilder(column: $table.notesNe, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StatisticsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StatisticsTable,
          Statistic,
          $$StatisticsTableFilterComposer,
          $$StatisticsTableOrderingComposer,
          $$StatisticsTableAnnotationComposer,
          $$StatisticsTableCreateCompanionBuilder,
          $$StatisticsTableUpdateCompanionBuilder,
          (
            Statistic,
            BaseReferences<_$AppDatabase, $StatisticsTable, Statistic>,
          ),
          Statistic,
          PrefetchHooks Function()
        > {
  $$StatisticsTableTableManager(_$AppDatabase db, $StatisticsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StatisticsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StatisticsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StatisticsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> districtId = const Value.absent(),
                Value<int> seasonYear = const Value.absent(),
                Value<int?> weekNumber = const Value.absent(),
                Value<int> caseCount = const Value.absent(),
                Value<String> reportedAt = const Value.absent(),
                Value<String?> notesEn = const Value.absent(),
                Value<String?> notesNe = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StatisticsCompanion(
                id: id,
                districtId: districtId,
                seasonYear: seasonYear,
                weekNumber: weekNumber,
                caseCount: caseCount,
                reportedAt: reportedAt,
                notesEn: notesEn,
                notesNe: notesNe,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int districtId,
                required int seasonYear,
                Value<int?> weekNumber = const Value.absent(),
                required int caseCount,
                required String reportedAt,
                Value<String?> notesEn = const Value.absent(),
                Value<String?> notesNe = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => StatisticsCompanion.insert(
                id: id,
                districtId: districtId,
                seasonYear: seasonYear,
                weekNumber: weekNumber,
                caseCount: caseCount,
                reportedAt: reportedAt,
                notesEn: notesEn,
                notesNe: notesNe,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StatisticsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StatisticsTable,
      Statistic,
      $$StatisticsTableFilterComposer,
      $$StatisticsTableOrderingComposer,
      $$StatisticsTableAnnotationComposer,
      $$StatisticsTableCreateCompanionBuilder,
      $$StatisticsTableUpdateCompanionBuilder,
      (Statistic, BaseReferences<_$AppDatabase, $StatisticsTable, Statistic>),
      Statistic,
      PrefetchHooks Function()
    >;
typedef $$ContactsTableCreateCompanionBuilder =
    ContactsCompanion Function({
      Value<int> id,
      Value<String?> nameEn,
      Value<String?> nameNe,
      required String phone,
      Value<int?> districtId,
      required String contactType,
      Value<bool> isActive,
      Value<int> sortOrder,
    });
typedef $$ContactsTableUpdateCompanionBuilder =
    ContactsCompanion Function({
      Value<int> id,
      Value<String?> nameEn,
      Value<String?> nameNe,
      Value<String> phone,
      Value<int?> districtId,
      Value<String> contactType,
      Value<bool> isActive,
      Value<int> sortOrder,
    });

class $$ContactsTableFilterComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameNe => $composableBuilder(
    column: $table.nameNe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get districtId => $composableBuilder(
    column: $table.districtId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactType => $composableBuilder(
    column: $table.contactType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameNe => $composableBuilder(
    column: $table.nameNe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get districtId => $composableBuilder(
    column: $table.districtId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactType => $composableBuilder(
    column: $table.contactType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameNe =>
      $composableBuilder(column: $table.nameNe, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<int> get districtId => $composableBuilder(
    column: $table.districtId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactType => $composableBuilder(
    column: $table.contactType,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$ContactsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContactsTable,
          Contact,
          $$ContactsTableFilterComposer,
          $$ContactsTableOrderingComposer,
          $$ContactsTableAnnotationComposer,
          $$ContactsTableCreateCompanionBuilder,
          $$ContactsTableUpdateCompanionBuilder,
          (Contact, BaseReferences<_$AppDatabase, $ContactsTable, Contact>),
          Contact,
          PrefetchHooks Function()
        > {
  $$ContactsTableTableManager(_$AppDatabase db, $ContactsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> nameNe = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<int?> districtId = const Value.absent(),
                Value<String> contactType = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => ContactsCompanion(
                id: id,
                nameEn: nameEn,
                nameNe: nameNe,
                phone: phone,
                districtId: districtId,
                contactType: contactType,
                isActive: isActive,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> nameNe = const Value.absent(),
                required String phone,
                Value<int?> districtId = const Value.absent(),
                required String contactType,
                Value<bool> isActive = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => ContactsCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameNe: nameNe,
                phone: phone,
                districtId: districtId,
                contactType: contactType,
                isActive: isActive,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ContactsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContactsTable,
      Contact,
      $$ContactsTableFilterComposer,
      $$ContactsTableOrderingComposer,
      $$ContactsTableAnnotationComposer,
      $$ContactsTableCreateCompanionBuilder,
      $$ContactsTableUpdateCompanionBuilder,
      (Contact, BaseReferences<_$AppDatabase, $ContactsTable, Contact>),
      Contact,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SyncMetadataTableTableManager get syncMetadata =>
      $$SyncMetadataTableTableManager(_db, _db.syncMetadata);
  $$DistrictsTableTableManager get districts =>
      $$DistrictsTableTableManager(_db, _db.districts);
  $$ArticlesTableTableManager get articles =>
      $$ArticlesTableTableManager(_db, _db.articles);
  $$NewsItemsTableTableManager get newsItems =>
      $$NewsItemsTableTableManager(_db, _db.newsItems);
  $$StatisticsTableTableManager get statistics =>
      $$StatisticsTableTableManager(_db, _db.statistics);
  $$ContactsTableTableManager get contacts =>
      $$ContactsTableTableManager(_db, _db.contacts);
}
