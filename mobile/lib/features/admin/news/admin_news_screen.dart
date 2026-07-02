import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/api/api_client.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/json_parse.dart';
import '../../../core/validation/admin_validators.dart';
import '../widgets/admin_widgets.dart';

class AdminNewsScreen extends ConsumerStatefulWidget {
  const AdminNewsScreen({super.key});

  @override
  ConsumerState<AdminNewsScreen> createState() => _AdminNewsScreenState();
}

class _AdminNewsScreenState extends ConsumerState<AdminNewsScreen> {
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _future = ref.read(adminApiProvider).listNews();
  }

  Future<void> _delete(int id, String label) async {
    final ok = await confirmDelete(context, label);
    if (ok != true || !mounted) return;
    try {
      await ref.read(adminApiProvider).delete('news', id);
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
      title: 'News',
      fab: FloatingActionButton(
        onPressed: () async {
          await context.push('/admin/news/new');
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
            return const Center(child: Text('No news yet.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = items[index];
              final title = pickLocalizedText(
                item['titleEn'] as String?,
                item['titleNe'] as String?,
              );
              return Card(
                child: ListTile(
                  title: Text(title.isEmpty ? item['slug'] as String : title),
                  subtitle: AdminStatusChip(
                    status: item['status'] as String? ?? 'draft',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _delete(
                      item['id'] as int,
                      title.isEmpty ? item['slug'] as String : title,
                    ),
                  ),
                  onTap: () async {
                    await context.push('/admin/news/${item['id']}');
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

class AdminNewsFormScreen extends ConsumerStatefulWidget {
  const AdminNewsFormScreen({super.key, this.id});

  final int? id;

  @override
  ConsumerState<AdminNewsFormScreen> createState() => _AdminNewsFormScreenState();
}

class _AdminNewsFormScreenState extends ConsumerState<AdminNewsFormScreen> {
  final _picker = ImagePicker();
  final _slug = TextEditingController();
  final _titleEn = TextEditingController();
  final _titleNe = TextEditingController();
  final _summaryEn = TextEditingController();
  final _summaryNe = TextEditingController();
  final _bodyEn = TextEditingController();
  final _bodyNe = TextEditingController();
  final _sourceName = TextEditingController();
  final _sourceUrl = TextEditingController();
  final _externalUrl = TextEditingController();
  final _sortOrder = TextEditingController(text: '0');
  final _coverMediaId = TextEditingController();

  String _status = 'draft';
  bool _loading = false;
  bool _initialLoading = false;
  bool _uploadingCover = false;
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
      final item = await ref.read(adminApiProvider).getById('news', widget.id!);
      _slug.text = item['slug'] as String? ?? '';
      _titleEn.text = item['titleEn'] as String? ?? '';
      _titleNe.text = item['titleNe'] as String? ?? '';
      _summaryEn.text = item['summaryEn'] as String? ?? '';
      _summaryNe.text = item['summaryNe'] as String? ?? '';
      _bodyEn.text = item['bodyEn'] as String? ?? '';
      _bodyNe.text = item['bodyNe'] as String? ?? '';
      _sourceName.text = item['sourceName'] as String? ?? '';
      _sourceUrl.text = item['sourceUrl'] as String? ?? '';
      _externalUrl.text = item['externalUrl'] as String? ?? '';
      _sortOrder.text = '${item['sortOrder'] ?? 0}';
      _coverMediaId.text =
          item['coverMediaId'] != null ? '${item['coverMediaId']}' : '';
      _status = item['status'] as String? ?? 'draft';
    } catch (e) {
      _error = e.toString();
    } finally {
      if (mounted) setState(() => _initialLoading = false);
    }
  }

  @override
  void dispose() {
    _slug.dispose();
    _titleEn.dispose();
    _titleNe.dispose();
    _summaryEn.dispose();
    _summaryNe.dispose();
    _bodyEn.dispose();
    _bodyNe.dispose();
    _sourceName.dispose();
    _sourceUrl.dispose();
    _externalUrl.dispose();
    _sortOrder.dispose();
    _coverMediaId.dispose();
    super.dispose();
  }

  Map<String, dynamic> _buildBody() {
    final coverId = int.tryParse(_coverMediaId.text.trim());
    return {
      'slug': _slug.text.trim(),
      'titleEn': emptyToNull(_titleEn.text),
      'titleNe': emptyToNull(_titleNe.text),
      'summaryEn': emptyToNull(_summaryEn.text),
      'summaryNe': emptyToNull(_summaryNe.text),
      'bodyEn': emptyToNull(_bodyEn.text),
      'bodyNe': emptyToNull(_bodyNe.text),
      'sourceName': emptyToNull(_sourceName.text),
      'sourceUrl': emptyToNull(_sourceUrl.text),
      'externalUrl': emptyToNull(_externalUrl.text),
      'coverMediaId': coverId,
      'status': _status,
      'sortOrder': int.tryParse(_sortOrder.text.trim()) ?? 0,
      if (_status == 'published') 'publishedAt': DateTime.now().toIso8601String(),
    };
  }

  Future<void> _uploadCoverImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null || !mounted) return;

    setState(() {
      _uploadingCover = true;
      _error = null;
    });

    try {
      final bytes = await picked.readAsBytes();
      final media = await ref.read(adminApiProvider).uploadMedia(bytes, picked.name);
      _coverMediaId.text = '${media['id']}';
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cover image uploaded')),
        );
      }
    } on ApiException catch (e) {
      setState(() => _error = e.message);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) {
        setState(() => _uploadingCover = false);
      }
    }
  }

  Future<void> _save() async {
    final slugErr = AdminValidators.validateSlug(_slug.text);
    final publishErr = AdminValidators.validatePublishableContent(
      status: _status,
      titleEn: _titleEn.text,
      titleNe: _titleNe.text,
      bodyEn: _bodyEn.text,
      bodyNe: _bodyNe.text,
    );
    final validationError = slugErr ?? publishErr;
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
        await api.update('news', widget.id!, body);
      } else {
        await api.create('news', body);
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
        title: Text(_isEdit ? 'Edit news' : 'New news'),
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
            controller: _slug,
            decoration: const InputDecoration(labelText: 'Slug'),
          ),
          const SizedBox(height: 16),
          BilingualFields(
            titleEnController: _titleEn,
            titleNeController: _titleNe,
            summaryEnController: _summaryEn,
            summaryNeController: _summaryNe,
            bodyEnController: _bodyEn,
            bodyNeController: _bodyNe,
            showSummary: true,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _sourceName,
            decoration: const InputDecoration(labelText: 'Source name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _sourceUrl,
            decoration: const InputDecoration(labelText: 'Source URL'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _externalUrl,
            decoration: const InputDecoration(labelText: 'External URL'),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _status,
            decoration: const InputDecoration(labelText: 'Status'),
            items: AdminValidators.statuses
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (v) => setState(() => _status = v ?? 'draft'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _sortOrder,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Sort order'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _coverMediaId,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Cover media ID (optional)',
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: (_loading || _uploadingCover) ? null : _uploadCoverImage,
            icon: _uploadingCover
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.upload_file),
            label: Text(
              _uploadingCover ? 'Uploading cover image...' : 'Upload cover image',
            ),
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
