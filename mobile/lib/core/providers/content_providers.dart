import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import 'app_providers.dart';

final districtsStreamProvider = StreamProvider<List<District>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.districts)..orderBy([(d) => OrderingTerm.asc(d.nameEn)]))
      .watch();
});

final articlesStreamProvider = StreamProvider<List<Article>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.articles)
        ..orderBy([
          (a) => OrderingTerm.desc(a.publishedAt),
          (a) => OrderingTerm.asc(a.sortOrder),
        ]))
      .watch();
});

final articleByIdProvider =
    StreamProvider.family<Article?, int>((ref, id) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.articles)..where((a) => a.id.equals(id)))
      .watchSingleOrNull();
});

final newsStreamProvider = StreamProvider<List<NewsItem>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.newsItems)
        ..orderBy([
          (n) => OrderingTerm.desc(n.publishedAt),
          (n) => OrderingTerm.asc(n.sortOrder),
        ]))
      .watch();
});

final newsByIdProvider = StreamProvider.family<NewsItem?, int>((ref, id) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.newsItems)..where((n) => n.id.equals(id)))
      .watchSingleOrNull();
});

final statisticsStreamProvider = StreamProvider<List<Statistic>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.statistics)
        ..orderBy([
          (s) => OrderingTerm.desc(s.seasonYear),
          (s) => OrderingTerm.desc(s.caseCount),
        ]))
      .watch();
});

final contactsStreamProvider = StreamProvider<List<Contact>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.contacts)
        ..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]))
      .watch();
});

final districtByIdProvider =
    StreamProvider.family<District?, int>((ref, id) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.districts)..where((d) => d.id.equals(id)))
      .watchSingleOrNull();
});
