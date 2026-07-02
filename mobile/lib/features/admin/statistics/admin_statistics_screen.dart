import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_client.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/validation/admin_validators.dart';
import '../widgets/admin_widgets.dart';

class AdminStatisticsScreen extends ConsumerStatefulWidget {
  const AdminStatisticsScreen({super.key});

  @override
  ConsumerState<AdminStatisticsScreen> createState() =>
      _AdminStatisticsScreenState();
}

class _AdminStatisticsScreenState extends ConsumerState<AdminStatisticsScreen> {
  late Future<List<Map<String, dynamic>>> _future;
  late Future<List<Map<String, dynamic>>> _districtsFuture;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    final api = ref.read(adminApiProvider);
    _future = api.listStatistics();
    _districtsFuture = api.listDistricts();
  }

  Future<void> _delete(int id) async {
    final ok = await confirmDelete(context, 'this statistic');
    if (ok != true || !mounted) return;
    try {
      await ref.read(adminApiProvider).delete('statistics', id);
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
      title: 'Statistics',
      fab: FloatingActionButton(
        onPressed: () async {
          await context.push('/admin/statistics/new');
          _reload();
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<List<Map<String, dynamic>>>>(
        future: Future.wait([_future, _districtsFuture]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final results = snapshot.data!;
          final items = results[0];
          final districts = results[1];
          final districtMap = <int, String>{
            for (final d in districts) d['id'] as int: d['code'] as String,
          };

          if (items.isEmpty) {
            return const Center(child: Text('No statistics yet.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = items[index];
              final districtCode =
                  districtMap[item['districtId'] as int] ?? 'District';
              return Card(
                child: ListTile(
                  title: Text('$districtCode · ${item['seasonYear']}'),
                  subtitle: Text('Reported ${item['reportedAt']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${item['caseCount']}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _delete(item['id'] as int),
                      ),
                    ],
                  ),
                  onTap: () async {
                    await context.push('/admin/statistics/${item['id']}');
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

class AdminStatisticFormScreen extends ConsumerStatefulWidget {
  const AdminStatisticFormScreen({super.key, this.id});

  final int? id;

  @override
  ConsumerState<AdminStatisticFormScreen> createState() =>
      _AdminStatisticFormScreenState();
}

class _AdminStatisticFormScreenState
    extends ConsumerState<AdminStatisticFormScreen> {
  final _seasonYear = TextEditingController();
  final _weekNumber = TextEditingController();
  final _caseCount = TextEditingController();
  final _reportedAt = TextEditingController();
  final _notesEn = TextEditingController();
  final _notesNe = TextEditingController();

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
            await ref.read(adminApiProvider).getById('statistics', widget.id!);
        _districtId = item['districtId'] as int?;
        _seasonYear.text = '${item['seasonYear']}';
        _weekNumber.text = item['weekNumber']?.toString() ?? '';
        _caseCount.text = '${item['caseCount']}';
        _reportedAt.text = item['reportedAt'] as String? ?? '';
        _notesEn.text = item['notesEn'] as String? ?? '';
        _notesNe.text = item['notesNe'] as String? ?? '';
      } else if (_districts.isNotEmpty) {
        _districtId = _districts.first['id'] as int;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      if (mounted) setState(() => _initialLoading = false);
    }
  }

  @override
  void dispose() {
    _seasonYear.dispose();
    _weekNumber.dispose();
    _caseCount.dispose();
    _reportedAt.dispose();
    _notesEn.dispose();
    _notesNe.dispose();
    super.dispose();
  }

  Map<String, dynamic> _buildBody() {
    final week = int.tryParse(_weekNumber.text.trim());
    return {
      'districtId': _districtId,
      'seasonYear': int.parse(_seasonYear.text.trim()),
      'weekNumber': week,
      'caseCount': int.parse(_caseCount.text.trim()),
      'reportedAt': _reportedAt.text.trim(),
      'notesEn': emptyToNull(_notesEn.text),
      'notesNe': emptyToNull(_notesNe.text),
    };
  }

  Future<void> _save() async {
    final validationError = AdminValidators.validateStatistic(
      districtId: _districtId,
      seasonYear: int.tryParse(_seasonYear.text.trim()),
      caseCount: int.tryParse(_caseCount.text.trim()),
      reportedAt: _reportedAt.text,
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
        await api.update('statistics', widget.id!, body);
      } else {
        await api.create('statistics', body);
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
        title: Text(_isEdit ? 'Edit statistic' : 'New statistic'),
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
          DropdownButtonFormField<int>(
            initialValue: _districtId,
            decoration: const InputDecoration(labelText: 'District'),
            items: _districts
                .map(
                  (d) => DropdownMenuItem(
                    value: d['id'] as int,
                    child: Text(d['code'] as String),
                  ),
                )
                .toList(),
            onChanged: (v) => setState(() => _districtId = v),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _seasonYear,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Season year'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _weekNumber,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Week number (optional)',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _caseCount,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Case count'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _reportedAt,
            decoration: const InputDecoration(
              labelText: 'Reported at',
              hintText: 'e.g. 2026-W26',
            ),
          ),
          const SizedBox(height: 16),
          BilingualFields(
            titleEnController: _notesEn,
            titleNeController: _notesNe,
            titleLabel: 'Notes',
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
