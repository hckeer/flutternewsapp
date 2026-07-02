import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

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

class ArticlesScreen extends ConsumerWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(articlesStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Articles')),
      body: OfflineBanner(
        child: RefreshIndicator(
          onRefresh: () => ref.read(syncControllerProvider.notifier).syncNow(),
          child: articles.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => ErrorRetry(
              message: err.toString(),
              onRetry: () => ref.invalidate(articlesStreamProvider),
            ),
            data: (items) {
              if (items.isEmpty) {
                return ListView(
                  children: const [
                    SizedBox(height: 120),
                    EmptyState(
                      icon: Icons.article_outlined,
                      message: 'No articles yet. Sync when online.',
                    ),
                  ],
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final article = items[index];
                  final title =
                      pickLocalizedText(article.titleEn, article.titleNe);
                  final summary =
                      pickLocalizedText(article.summaryEn, article.summaryNe);
                  final coverUrl = _resolveCoverUrl(article.coverMediaUrl);
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
                      subtitle: summary.isNotEmpty ? Text(summary) : null,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/articles/${article.id}'),
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

class ArticleDetailScreen extends ConsumerWidget {
  const ArticleDetailScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final article = ref.watch(articleByIdProvider(id));

    return Scaffold(
      appBar: AppBar(title: const Text('Article')),
      body: OfflineBanner(
        child: article.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => ErrorRetry(
            message: err.toString(),
            onRetry: () => ref.invalidate(articleByIdProvider(id)),
          ),
          data: (item) {
            if (item == null) {
              return const EmptyState(
                icon: Icons.article_outlined,
                message: 'Article not found.',
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
                if (item.publishedAt != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _formatDate(item.publishedAt!),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
                const SizedBox(height: 16),
                MarkdownBody(data: body),
              ],
            );
          },
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
