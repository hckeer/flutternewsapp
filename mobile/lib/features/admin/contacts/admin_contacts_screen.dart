import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_client.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/json_parse.dart';
import '../../../core/validation/admin_validators.dart';
import '../widgets/admin_widgets.dart';

class AdminContactsScreen extends ConsumerStatefulWidget {
  const AdminContactsScreen({super.key});

  @override
  ConsumerState<AdminContactsScreen> createState() =>
      _AdminContactsScreenState();
}

class _AdminContactsScreenState extends ConsumerState<AdminContactsScreen> {
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _future = ref.read(adminApiProvider).listContacts();
  }

  Future<void> _delete(int id, String label) async {
    final ok = await confirmDelete(context, label);
    if (ok != true || !mounted) return;
    try {
      await ref.read(adminApiProvider).delete('contacts', id);
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
      title: 'Contacts',
      fab: FloatingActionButton(
        onPressed: () async {
          await context.push('/admin/contacts/new');
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
            return const Center(child: Text('No contacts yet.'));
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
                  title: Text(name.isEmpty ? item['phone'] as String : name),
                  subtitle: Text(
                    '${item['contactType']} · ${item['phone']}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _delete(
                      item['id'] as int,
                      name.isEmpty ? item['phone'] as String : name,
                    ),
                  ),
                  onTap: () async {
                    await context.push('/admin/contacts/${item['id']}');
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

class AdminContactFormScreen extends ConsumerStatefulWidget {
  const AdminContactFormScreen({super.key, this.id});

  final int? id;

  @override
  ConsumerState<AdminContactFormScreen> createState() =>
      _AdminContactFormScreenState();
}

class _AdminContactFormScreenState
    extends ConsumerState<AdminContactFormScreen> {
  final _nameEn = TextEditingController();
  final _nameNe = TextEditingController();
  final _phone = TextEditingController();
  final _sortOrder = TextEditingController(text: '0');

  String _contactType = 'hotline';
  bool _isActive = true;
  int? _districtId;
  List<Map<String, dynamic>> _districts = [];

  bool _loading = false;
  bool _initialLoading = false;
  String? _error;

  bool get _isEdit => widget.id != null;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    setState(() => _initialLoading = true);
    try {
      _districts = await ref.read(adminApiProvider).listDistricts();
      if (_isEdit) {
        final item =
            await ref.read(adminApiProvider).getById('contacts', widget.id!);
        _nameEn.text = item['nameEn'] as String? ?? '';
        _nameNe.text = item['nameNe'] as String? ?? '';
        _phone.text = item['phone'] as String? ?? '';
        _sortOrder.text = '${item['sortOrder'] ?? 0}';
        _contactType = item['contactType'] as String? ?? 'hotline';
        _isActive = item['isActive'] as bool? ?? true;
        _districtId = item['districtId'] as int?;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      if (mounted) setState(() => _initialLoading = false);
    }
  }

  @override
  void dispose() {
    _nameEn.dispose();
    _nameNe.dispose();
    _phone.dispose();
    _sortOrder.dispose();
    super.dispose();
  }

  Map<String, dynamic> _buildBody() {
    return {
      'nameEn': emptyToNull(_nameEn.text),
      'nameNe': emptyToNull(_nameNe.text),
      'phone': _phone.text.trim(),
      'districtId': _districtId,
      'contactType': _contactType,
      'isActive': _isActive,
      'sortOrder': int.tryParse(_sortOrder.text.trim()) ?? 0,
    };
  }

  Future<void> _save() async {
    final phoneErr = AdminValidators.validatePhone(_phone.text);
    final activeErr = AdminValidators.validateActiveContact(
      isActive: _isActive,
      nameEn: _nameEn.text,
      nameNe: _nameNe.text,
    );
    final validationError = phoneErr ?? activeErr;
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
        await api.update('contacts', widget.id!, body);
      } else {
        await api.create('contacts', body);
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
        title: Text(_isEdit ? 'Edit contact' : 'New contact'),
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
          BilingualFields(
            titleEnController: _nameEn,
            titleNeController: _nameNe,
            titleLabel: 'Name',
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'Phone'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _contactType,
            decoration: const InputDecoration(labelText: 'Contact type'),
            items: AdminValidators.contactTypes
                .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                .toList(),
            onChanged: (v) => setState(() => _contactType = v ?? 'hotline'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int?>(
            initialValue: _districtId,
            decoration: const InputDecoration(
              labelText: 'District (optional)',
            ),
            items: [
              const DropdownMenuItem<int?>(
                value: null,
                child: Text('None'),
              ),
              ..._districts.map(
                (d) => DropdownMenuItem<int?>(
                  value: d['id'] as int,
                  child: Text(d['code'] as String),
                ),
              ),
            ],
            onChanged: (v) => setState(() => _districtId = v),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _sortOrder,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Sort order'),
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            title: const Text('Active'),
            value: _isActive,
            onChanged: (v) => setState(() => _isActive = v),
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
