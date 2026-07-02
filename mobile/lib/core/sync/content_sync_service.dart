import 'package:drift/drift.dart';
import '../api/api_client.dart';
import '../database/app_database.dart';
import '../utils/json_parse.dart';

class SyncException implements Exception {
  SyncException(this.message);
  final String message;

  @override
  String toString() => message;
}

class ContentSyncService {
  ContentSyncService(this._db, this._api);

  final AppDatabase _db;
  final ApiClient _api;

  Future<void> syncAll() async {
    await _db.transaction(() async {
      await _syncDistricts();
      await _syncArticles();
      await _syncNews();
      await _syncStatistics();
      await _syncContacts();
      await _db.setLastSyncedAt(DateTime.now());
    });
  }

  Future<void> _syncDistricts() async {
    final response = await _api.get('/public/districts');
    final items = response['data'] as List<dynamic>;
    final ids = <int>[];

    for (final raw in items) {
      final map = raw as Map<String, dynamic>;
      final id = map['id'] as int;
      ids.add(id);
      await _db.into(_db.districts).insertOnConflictUpdate(
            DistrictsCompanion(
              id: Value(id),
              code: Value(map['code'] as String),
              nameEn: Value(map['nameEn'] as String?),
              nameNe: Value(map['nameNe'] as String?),
              provinceEn: Value(map['provinceEn'] as String),
              latitude: Value((map['latitude'] as num?)?.toDouble()),
              longitude: Value((map['longitude'] as num?)?.toDouble()),
            ),
          );
    }

    if (ids.isEmpty) {
      await _db.delete(_db.districts).go();
    } else {
      await (_db.delete(_db.districts)..where((d) => d.id.isNotIn(ids))).go();
    }
  }

  Future<void> _syncArticles() async {
    final response = await _api.get('/public/articles');
    final items = response['data'] as List<dynamic>;
    final ids = <int>[];

    for (final raw in items) {
      final map = raw as Map<String, dynamic>;
      final id = map['id'] as int;
      ids.add(id);
      await _db.into(_db.articles).insertOnConflictUpdate(
            ArticlesCompanion(
              id: Value(id),
              slug: Value(map['slug'] as String),
              titleEn: Value(map['titleEn'] as String?),
              titleNe: Value(map['titleNe'] as String?),
              summaryEn: Value(map['summaryEn'] as String?),
              summaryNe: Value(map['summaryNe'] as String?),
              bodyEn: Value(map['bodyEn'] as String?),
              bodyNe: Value(map['bodyNe'] as String?),
              coverMediaId: Value(map['coverMediaId'] as int?),
              coverMediaUrl: Value(map['coverMediaUrl'] as String?),
              status: Value(map['status'] as String),
              publishedAt: Value(parseApiDate(map['publishedAt'])),
              sortOrder: Value(map['sortOrder'] as int? ?? 0),
              createdAt: Value(parseApiDateRequired(map['createdAt'])),
              updatedAt: Value(parseApiDateRequired(map['updatedAt'])),
            ),
          );
    }

    if (ids.isEmpty) {
      await _db.delete(_db.articles).go();
    } else {
      await (_db.delete(_db.articles)..where((a) => a.id.isNotIn(ids))).go();
    }
  }

  Future<void> _syncNews() async {
    final response = await _api.get('/public/news');
    final items = response['data'] as List<dynamic>;
    final ids = <int>[];

    for (final raw in items) {
      final map = raw as Map<String, dynamic>;
      final id = map['id'] as int;
      ids.add(id);
      await _db.into(_db.newsItems).insertOnConflictUpdate(
            NewsItemsCompanion(
              id: Value(id),
              slug: Value(map['slug'] as String),
              titleEn: Value(map['titleEn'] as String?),
              titleNe: Value(map['titleNe'] as String?),
              summaryEn: Value(map['summaryEn'] as String?),
              summaryNe: Value(map['summaryNe'] as String?),
              bodyEn: Value(map['bodyEn'] as String?),
              bodyNe: Value(map['bodyNe'] as String?),
              sourceName: Value(map['sourceName'] as String?),
              sourceUrl: Value(map['sourceUrl'] as String?),
              externalUrl: Value(map['externalUrl'] as String?),
              coverMediaId: Value(map['coverMediaId'] as int?),
              coverMediaUrl: Value(map['coverMediaUrl'] as String?),
              status: Value(map['status'] as String),
              publishedAt: Value(parseApiDate(map['publishedAt'])),
              sortOrder: Value(map['sortOrder'] as int? ?? 0),
              createdAt: Value(parseApiDateRequired(map['createdAt'])),
              updatedAt: Value(parseApiDateRequired(map['updatedAt'])),
            ),
          );
    }

    if (ids.isEmpty) {
      await _db.delete(_db.newsItems).go();
    } else {
      await (_db.delete(_db.newsItems)..where((n) => n.id.isNotIn(ids))).go();
    }
  }

  Future<void> _syncStatistics() async {
    final response = await _api.get('/public/statistics');
    final items = response['data'] as List<dynamic>;
    final ids = <int>[];

    for (final raw in items) {
      final map = raw as Map<String, dynamic>;
      final id = map['id'] as int;
      ids.add(id);
      await _db.into(_db.statistics).insertOnConflictUpdate(
            StatisticsCompanion(
              id: Value(id),
              districtId: Value(map['districtId'] as int),
              seasonYear: Value(map['seasonYear'] as int),
              weekNumber: Value(map['weekNumber'] as int?),
              caseCount: Value(map['caseCount'] as int),
              reportedAt: Value(map['reportedAt'] as String),
              notesEn: Value(map['notesEn'] as String?),
              notesNe: Value(map['notesNe'] as String?),
              createdAt: Value(parseApiDateRequired(map['createdAt'])),
              updatedAt: Value(parseApiDateRequired(map['updatedAt'])),
            ),
          );
    }

    if (ids.isEmpty) {
      await _db.delete(_db.statistics).go();
    } else {
      await (_db.delete(_db.statistics)..where((s) => s.id.isNotIn(ids))).go();
    }
  }

  Future<void> _syncContacts() async {
    final response = await _api.get('/public/contacts');
    final items = response['data'] as List<dynamic>;
    final ids = <int>[];

    for (final raw in items) {
      final map = raw as Map<String, dynamic>;
      final id = map['id'] as int;
      ids.add(id);
      await _db.into(_db.contacts).insertOnConflictUpdate(
            ContactsCompanion(
              id: Value(id),
              nameEn: Value(map['nameEn'] as String?),
              nameNe: Value(map['nameNe'] as String?),
              phone: Value(map['phone'] as String),
              districtId: Value(map['districtId'] as int?),
              contactType: Value(map['contactType'] as String),
              isActive: Value(map['isActive'] as bool? ?? true),
              sortOrder: Value(map['sortOrder'] as int? ?? 0),
            ),
          );
    }

    if (ids.isEmpty) {
      await _db.delete(_db.contacts).go();
    } else {
      await (_db.delete(_db.contacts)..where((c) => c.id.isNotIn(ids))).go();
    }
  }
}
