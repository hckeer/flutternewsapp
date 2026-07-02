import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/auth/auth_session.dart';
import '../../core/config/api_config.dart';
import '../../core/providers/app_providers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _message;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _message = null;
    });
    try {
      await ref.read(authSessionProvider.notifier).login(
            _usernameController.text.trim(),
            _passwordController.text,
          );
      setState(() {
        _message = 'Logged in successfully.';
        _passwordController.clear();
      });
    } catch (e) {
      setState(() => _message = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _logout() async {
    await ref.read(authSessionProvider.notifier).logout();
    setState(() => _message = 'Logged out.');
  }

  Future<void> _syncNow() async {
    setState(() {
      _loading = true;
      _message = null;
    });
    try {
      await ref.read(syncControllerProvider.notifier).syncNow();
      setState(() => _message = 'Content synced.');
    } catch (e) {
      setState(() => _message = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  String _formatLastSynced(DateTime? at) {
    if (at == null) return 'Never';
    return '${at.day}/${at.month}/${at.year} ${at.hour.toString().padLeft(2, '0')}:${at.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authSessionProvider);
    final isLoggedIn = auth.maybeWhen(
      data: (s) => s.isLoggedIn,
      orElse: () => false,
    );
    final lastSynced = ref.watch(lastSyncedAtProvider);
    final isOnline = ref.watch(isOnlineProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: const Text('API endpoint'),
            subtitle: Text(ApiConfig.baseUrl),
          ),
          ListTile(
            title: const Text('Connection'),
            subtitle: Text(isOnline ? 'Online' : 'Offline'),
            leading: Icon(isOnline ? Icons.wifi : Icons.wifi_off),
          ),
          lastSynced.when(
            data: (at) => ListTile(
              title: const Text('Last synced'),
              subtitle: Text(_formatLastSynced(at)),
              leading: const Icon(Icons.sync),
            ),
            loading: () => const ListTile(
              title: Text('Last synced'),
              subtitle: Text('…'),
            ),
            error: (_, _) => const ListTile(
              title: Text('Last synced'),
              subtitle: Text('Unknown'),
            ),
          ),
          FilledButton.tonalIcon(
            onPressed: _loading || !isOnline ? null : _syncNow,
            icon: const Icon(Icons.refresh),
            label: const Text('Sync now'),
          ),
          const Divider(height: 32),
          if (isLoggedIn) ...[
            ListTile(
              title: const Text('Admin'),
              subtitle: const Text('You are logged in as admin'),
              leading: const Icon(Icons.admin_panel_settings_outlined),
            ),
            FilledButton.icon(
              onPressed: () => context.push('/admin'),
              icon: const Icon(Icons.dashboard_outlined),
              label: const Text('Open admin panel'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: _loading ? null : _logout,
              child: const Text('Logout'),
            ),
          ] else ...[
            Text('Login as admin',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _loading ? null : _login,
              child: _loading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Login as admin'),
            ),
          ],
          if (_message != null) ...[
            const SizedBox(height: 12),
            Text(_message!),
          ],
        ],
      ),
    );
  }
}
