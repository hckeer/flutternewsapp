import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_client.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/json_parse.dart';
import '../../../core/validation/admin_validators.dart';
import '../widgets/admin_widgets.dart';

class AdminDistrictsScreen extends ConsumerStatefulWidget {
  const AdminDistrictsScreen({super.key});

  @override
  ConsumerState<AdminDistrictsScreen> createState() =>
      _AdminDistrictsScreenState();
}

class _AdminDistrictsScreenState extends ConsumerState<AdminDistrictsScreen> {
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _future = ref.read(adminApiProvider).listDistricts();
  }

  Future<void> _delete(int id, String label) async {
    final ok = await confirmDelete(context, label);
    if (ok != true || !mounted) return;
    try {
      await ref.read(adminApiProvider).delete('districts', id);
      _reload();
      setState(() {});
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Districts',
      fab: FloatingActionButton(
        onPressed: () async {
          await context.push('/admin/districts/new');
          _reload();
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text('No districts yet.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = items[index];
              final name = pickLocalizedText(
                item['nameEn'] as String?,
                item['nameNe'] as String?,
              );
              return Card(
                child: ListTile(
                  title: Text(name.isEmpty ? item['code'] as String : name),
                  subtitle: Text(item['provinceEn'] as String? ?? ''),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _delete(
                      item['id'] as int,
                      name.isEmpty ? item['code'] as String : name,
                    ),
                  ),
                  onTap: () async {
                    await context.push('/admin/districts/${item['id']}');
                    _reload();
                    setState(() {});
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AdminDistrictFormScreen extends ConsumerStatefulWidget {
  const AdminDistrictFormScreen({super.key, this.id});

  final int? id;

  @override
  ConsumerState<AdminDistrictFormScreen> createState() =>
      _AdminDistrictFormScreenState();
}

class _AdminDistrictFormScreenState
    extends ConsumerState<AdminDistrictFormScreen> {
  final _code = TextEditingController();
  final _nameEn = TextEditingController();
  final _nameNe = TextEditingController();
  final _provinceEn = TextEditingController();
  final _latitude = TextEditingController();
  final _longitude = TextEditingController();

  bool _loading = false;
  bool _initialLoading = false;
  String? _error;

  bool get _isEdit => widget.id != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) _load();
  }

  Future<void> _load() async {
    setState(() => _initialLoading = true);
    try {
      final item =
          await ref.read(adminApiProvider).getById('districts', widget.id!);
      _code.text = item['code'] as String? ?? '';
      _nameEn.text = item['nameEn'] as String? ?? '';
      _nameNe.text = item['nameNe'] as String? ?? '';
      _provinceEn.text = item['provinceEn'] as String? ?? '';
      _latitude.text = item['latitude']?.toString() ?? '';
      _longitude.text = item['longitude']?.toString() ?? '';
    } catch (e) {
      _error = e.toString();
    } finally {
      if (mounted) setState(() => _initialLoading = false);
    }
  }

  @override
  void dispose() {
    _code.dispose();
    _nameEn.dispose();
    _nameNe.dispose();
    _provinceEn.dispose();
    _latitude.dispose();
    _longitude.dispose();
    super.dispose();
  }

  Map<String, dynamic> _buildBody() {
    final lat = double.tryParse(_latitude.text.trim());
    final lng = double.tryParse(_longitude.text.trim());
    return {
      'code': _code.text.trim(),
      'nameEn': emptyToNull(_nameEn.text),
      'nameNe': emptyToNull(_nameNe.text),
      'provinceEn': _provinceEn.text.trim(),
      'latitude': lat,
      'longitude': lng,
    };
  }

  Future<void> _save() async {
    final validationError = AdminValidators.validateDistrict(
      code: _code.text,
      provinceEn: _provinceEn.text,
    );
    if (validationError != null) {
      setState(() => _error = validationError);
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final body = _buildBody();
      final api = ref.read(adminApiProvider);
      if (_isEdit) {
        await api.update('districts', widget.id!, body);
      } else {
        await api.create('districts', body);
      }
      if (mounted) context.pop();
    } on ApiException catch (e) {
      setState(() => _error = e.message);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initialLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit district' : 'New district'),
        actions: [
          TextButton(
            onPressed: _loading ? null : _save,
            child: _loading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _code,
            decoration: const InputDecoration(labelText: 'Code'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _provinceEn,
            decoration: const InputDecoration(labelText: 'Province (English)'),
          ),
          const SizedBox(height: 16),
          BilingualFields(
            titleEnController: _nameEn,
            titleNeController: _nameNe,
            titleLabel: 'Name',
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _latitude,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Latitude (optional)'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _longitude,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Longitude (optional)'),
          ),
          if (_error != null) ...[
            const SizedBox(height: 16),
            Text(_error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ],
        ],
      ),
    );
  }
}
