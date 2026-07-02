import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/admin_api.dart';
import '../auth/auth_session.dart';
import '../database/app_database.dart';
import '../sync/content_sync_service.dart';
import 'foundation_providers.dart';

final authInitProvider = FutureProvider<void>((ref) async {
  await ref.read(authSessionProvider.future);
});

final adminApiProvider = Provider<AdminApi>((ref) {
  return AdminApi(ref.watch(apiClientProvider));
});

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final contentSyncServiceProvider = Provider<ContentSyncService>((ref) {
  return ContentSyncService(
    ref.watch(databaseProvider),
    ref.watch(apiClientProvider),
  );
});

final connectivityProvider = StreamProvider<List<ConnectivityResult>>((ref) {
  return Connectivity().onConnectivityChanged;
});

final isOnlineProvider = Provider<bool>((ref) {
  final connectivity = ref.watch(connectivityProvider);
  return connectivity.maybeWhen(
    data: (results) =>
        results.any((r) => r != ConnectivityResult.none),
    orElse: () => true,
  );
});

final lastSyncedAtProvider = StreamProvider<DateTime?>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.syncMetadata).watch().map((rows) {
    final row = rows.where((r) => r.key == 'content').firstOrNull;
    return row?.lastSyncedAt;
  });
});

final syncControllerProvider =
    AsyncNotifierProvider<SyncController, void>(SyncController.new);

class SyncController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> syncNow() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(contentSyncServiceProvider).syncAll();
    });
    if (state.hasError) throw state.error!;
  }
}
