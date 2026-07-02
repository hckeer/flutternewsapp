import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/config/api_config.dart';
import '../../core/providers/app_providers.dart';
import '../../core/providers/content_providers.dart';
import '../../core/utils/json_parse.dart';
import '../../core/widgets/error_retry.dart';
import '../../core/widgets/offline_banner.dart';

String? _resolveCoverUrl(String? urlPath) {
  if (urlPath == null || urlPath.isEmpty) return null;
  if (urlPath.startsWith('http://') || urlPath.startsWith('https://')) {
    return urlPath;
  }
  return '${ApiConfig.uploadsBaseUrl}$urlPath';
}

class NewsScreen extends ConsumerWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final news = ref.watch(newsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('News')),
      body: OfflineBanner(
        child: RefreshIndicator(
          onRefresh: () => ref.read(syncControllerProvider.notifier).syncNow(),
          child: news.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => ErrorRetry(
              message: err.toString(),
              onRetry: () => ref.invalidate(newsStreamProvider),
            ),
            data: (items) {
              if (items.isEmpty) {
                return ListView(
                  children: const [
                    SizedBox(height: 120),
                    EmptyState(
                      icon: Icons.newspaper_outlined,
                      message: 'No news yet. Sync when online.',
                    ),
                  ],
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = items[index];
                  final title = pickLocalizedText(item.titleEn, item.titleNe);
                  final summary =
                      pickLocalizedText(item.summaryEn, item.summaryNe);
                  final coverUrl = _resolveCoverUrl(item.coverMediaUrl);
                  return Card(
                    child: ListTile(
                      leading: coverUrl == null
                          ? null
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: CachedNetworkImage(
                                imageUrl: coverUrl,
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                                errorWidget: (_, _, _) =>
                                    const Icon(Icons.image_not_supported_outlined),
                              ),
                            ),
                      title: Text(title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (summary.isNotEmpty) Text(summary),
                          if (item.sourceName != null)
                            Text(
                              item.sourceName!,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                        ],
                      ),
                      isThreeLine: true,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/news/${item.id}'),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class NewsDetailScreen extends ConsumerWidget {
  const NewsDetailScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final news = ref.watch(newsByIdProvider(id));

    return Scaffold(
      appBar: AppBar(title: const Text('News')),
      body: OfflineBanner(
        child: news.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => ErrorRetry(
            message: err.toString(),
            onRetry: () => ref.invalidate(newsByIdProvider(id)),
          ),
          data: (item) {
            if (item == null) {
              return const EmptyState(
                icon: Icons.newspaper_outlined,
                message: 'News item not found.',
              );
            }
            final title = pickLocalizedText(item.titleEn, item.titleNe);
            final body = pickLocalizedText(item.bodyEn, item.bodyNe);
            final coverUrl = _resolveCoverUrl(item.coverMediaUrl);
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (coverUrl != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: coverUrl,
                      height: 220,
                      fit: BoxFit.cover,
                      errorWidget: (_, _, _) =>
                          const SizedBox(
                            height: 220,
                            child: Center(
                              child: Icon(Icons.image_not_supported_outlined),
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                if (item.sourceName != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    item.sourceName!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
                if (item.publishedAt != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${item.publishedAt!.day}/${item.publishedAt!.month}/${item.publishedAt!.year}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
                const SizedBox(height: 16),
                if (body.isNotEmpty) MarkdownBody(data: body),
                if (item.externalUrl != null) ...[
                  const SizedBox(height: 16),
                  FilledButton.tonalIcon(
                    onPressed: () => _openUrl(item.externalUrl!),
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Read full story'),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
