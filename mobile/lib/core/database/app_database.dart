import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class SyncMetadata extends Table {
  TextColumn get key => text()();
  DateTimeColumn get lastSyncedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

class Districts extends Table {
  IntColumn get id => integer()();
  TextColumn get code => text()();
  TextColumn get nameEn => text().nullable()();
  TextColumn get nameNe => text().nullable()();
  TextColumn get provinceEn => text()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Articles extends Table {
  IntColumn get id => integer()();
  TextColumn get slug => text()();
  TextColumn get titleEn => text().nullable()();
  TextColumn get titleNe => text().nullable()();
  TextColumn get summaryEn => text().nullable()();
  TextColumn get summaryNe => text().nullable()();
  TextColumn get bodyEn => text().nullable()();
  TextColumn get bodyNe => text().nullable()();
  IntColumn get coverMediaId => integer().nullable()();
  TextColumn get coverMediaUrl => text().nullable()();
  TextColumn get status => text()();
  DateTimeColumn get publishedAt => dateTime().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class NewsItems extends Table {
  IntColumn get id => integer()();
  TextColumn get slug => text()();
  TextColumn get titleEn => text().nullable()();
  TextColumn get titleNe => text().nullable()();
  TextColumn get summaryEn => text().nullable()();
  TextColumn get summaryNe => text().nullable()();
  TextColumn get bodyEn => text().nullable()();
  TextColumn get bodyNe => text().nullable()();
  TextColumn get sourceName => text().nullable()();
  TextColumn get sourceUrl => text().nullable()();
  TextColumn get externalUrl => text().nullable()();
  IntColumn get coverMediaId => integer().nullable()();
  TextColumn get coverMediaUrl => text().nullable()();
  TextColumn get status => text()();
  DateTimeColumn get publishedAt => dateTime().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Statistics extends Table {
  IntColumn get id => integer()();
  IntColumn get districtId => integer()();
  IntColumn get seasonYear => integer()();
  IntColumn get weekNumber => integer().nullable()();
  IntColumn get caseCount => integer()();
  TextColumn get reportedAt => text()();
  TextColumn get notesEn => text().nullable()();
  TextColumn get notesNe => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Contacts extends Table {
  IntColumn get id => integer()();
  TextColumn get nameEn => text().nullable()();
  TextColumn get nameNe => text().nullable()();
  TextColumn get phone => text()();
  IntColumn get districtId => integer().nullable()();
  TextColumn get contactType => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [
  SyncMetadata,
  Districts,
  Articles,
  NewsItems,
  Statistics,
  Contacts,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(articles, articles.coverMediaUrl);
            await m.addColumn(newsItems, newsItems.coverMediaUrl);
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'dengue_nepal',
      native: DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  Future<DateTime?> getLastSyncedAt() async {
    final row = await (select(syncMetadata)
          ..where((t) => t.key.equals('content')))
        .getSingleOrNull();
    return row?.lastSyncedAt;
  }

  Future<void> setLastSyncedAt(DateTime at) {
    return into(syncMetadata).insertOnConflictUpdate(
      SyncMetadataCompanion.insert(key: 'content', lastSyncedAt: at),
    );
  }
}
