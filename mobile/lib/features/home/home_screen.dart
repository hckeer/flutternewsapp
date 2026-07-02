import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers/app_providers.dart';
import '../../core/providers/content_providers.dart';
import '../../core/utils/json_parse.dart';
import '../../core/widgets/error_retry.dart';
import '../../core/widgets/offline_banner.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final districts = ref.watch(districtsStreamProvider);
    final articles = ref.watch(articlesStreamProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dengue Nepal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: OfflineBanner(
        child: RefreshIndicator(
          onRefresh: () => ref.read(syncControllerProvider.notifier).syncNow(),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _HeroCard(scheme: scheme),
              const SizedBox(height: 20),
              Text(
                'Explore',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              _NavTile(
                icon: Icons.article_outlined,
                title: 'Articles',
                subtitle: articles.maybeWhen(
                  data: (items) => '${items.length} prevention guides',
                  orElse: () => 'Prevention & awareness',
                ),
                color: scheme.primaryContainer,
                onTap: () => context.push('/articles'),
              ),
              _NavTile(
                icon: Icons.newspaper_outlined,
                title: 'News',
                subtitle: 'Latest dengue updates',
                color: scheme.secondaryContainer,
                onTap: () => context.push('/news'),
              ),
              _NavTile(
                icon: Icons.bar_chart_outlined,
                title: 'Statistics',
                subtitle: 'Cases by district',
                color: scheme.tertiaryContainer,
                onTap: () => context.push('/statistics'),
              ),
              _NavTile(
                icon: Icons.local_hospital_outlined,
                title: 'Emergency contacts',
                subtitle: 'Hotlines & hospitals',
                color: scheme.errorContainer.withValues(alpha: 0.5),
                onTap: () => context.push('/contacts'),
              ),
              const SizedBox(height: 20),
              Text(
                'Districts',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              districts.when(
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (err, _) => ErrorRetry(
                  message: err.toString(),
                  onRetry: () => ref.invalidate(districtsStreamProvider),
                ),
                data: (items) {
                  if (items.isEmpty) {
                    return const EmptyState(
                      icon: Icons.map_outlined,
                      message:
                          'No districts yet. Pull down to sync when online.',
                    );
                  }
                  return Column(
                    children: items
                        .map(
                          (d) => Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: scheme.primaryContainer,
                                child: Text(
                                  d.code,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: scheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                              title: Text(
                                pickLocalizedText(d.nameEn, d.nameNe),
                              ),
                              subtitle: Text(d.provinceEn),
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [scheme.primary, scheme.primary.withValues(alpha: 0.75)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.shield_outlined, color: scheme.onPrimary, size: 32),
          const SizedBox(height: 12),
          Text(
            'Stay protected',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: scheme.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'Learn prevention, track local cases, and find emergency help — even offline after your first sync.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onPrimary.withValues(alpha: 0.9),
                ),
          ),
        ],
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Theme.of(context).colorScheme.onSurface),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
