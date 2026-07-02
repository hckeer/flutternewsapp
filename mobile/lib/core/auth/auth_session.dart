import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/foundation_providers.dart';

class AuthSession {
  const AuthSession({required this.isLoggedIn});

  final bool isLoggedIn;
}

class AuthSessionNotifier extends AsyncNotifier<AuthSession> {
  @override
  Future<AuthSession> build() async {
    final token = await ref.read(authRepositoryProvider).getToken();
    final client = ref.read(apiClientProvider);
    if (token != null) {
      client.setToken(token);
    }
    client.onUnauthorized = _handleUnauthorized;
    return AuthSession(isLoggedIn: token != null);
  }

  Future<void> _handleUnauthorized() async {
    await logout(silent: true);
  }

  Future<void> login(String username, String password) async {
    final client = ref.read(apiClientProvider);
    final response = await client.post(
      '/auth/login',
      body: {'username': username, 'password': password},
    );
    final token =
        (response['data'] as Map<String, dynamic>)['token'] as String;
    client.setToken(token);
    await ref.read(authRepositoryProvider).saveToken(token);
    state = const AsyncData(AuthSession(isLoggedIn: true));
  }

  Future<void> logout({bool silent = false}) async {
    await ref.read(authRepositoryProvider).clearToken();
    ref.read(apiClientProvider).setToken(null);
    state = const AsyncData(AuthSession(isLoggedIn: false));
  }
}

final authSessionProvider =
    AsyncNotifierProvider<AuthSessionNotifier, AuthSession>(
  AuthSessionNotifier.new,
);
