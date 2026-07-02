import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/config/api_config.dart';
import '../../../core/providers/app_providers.dart';
import '../widgets/admin_widgets.dart';

class AdminMediaScreen extends ConsumerStatefulWidget {
  const AdminMediaScreen({super.key});

  @override
  ConsumerState<AdminMediaScreen> createState() => _AdminMediaScreenState();
}

class _AdminMediaScreenState extends ConsumerState<AdminMediaScreen> {
  final _picker = ImagePicker();
  late Future<List<Map<String, dynamic>>> _future;
  bool _uploading = false;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _future = ref.read(adminApiProvider).listMedia();
  }

  Future<void> _upload() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final bytes = await picked.readAsBytes();
    final filename = picked.name;

    setState(() => _uploading = true);
    try {
      await ref.read(adminApiProvider).uploadMedia(bytes, filename);
      _reload();
      setState(() {});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image uploaded')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  Future<void> _delete(int id, String name) async {
    final ok = await confirmDelete(context, name);
    if (ok != true || !mounted) return;
    try {
      await ref.read(adminApiProvider).delete('media', id);
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

  bool _isImage(String mime) => mime.startsWith('image/');

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Media',
      fab: _uploading
          ? const FloatingActionButton(
              onPressed: null,
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          : FloatingActionButton(
              onPressed: _upload,
              child: const Icon(Icons.upload_file),
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
            return const Center(
              child: Text('No media yet. Tap + to upload an image.'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = items[index];
              final mime = item['mimeType'] as String? ?? '';
              final urlPath = item['urlPath'] as String? ?? '';
              final url = '${ApiConfig.uploadsBaseUrl}$urlPath';
              final name = item['originalName'] as String? ?? 'File';

              return Card(
                child: ListTile(
                  leading: _isImage(mime)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: CachedNetworkImage(
                            imageUrl: url,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorWidget: (_, _, _) =>
                                const Icon(Icons.broken_image),
                          ),
                        )
                      : const Icon(Icons.picture_as_pdf),
                  title: Text(name),
                  subtitle: Text('ID ${item['id']} · $mime'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _delete(item['id'] as int, name),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
