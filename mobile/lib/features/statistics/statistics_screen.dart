import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/providers/app_providers.dart';
import '../../core/providers/content_providers.dart';
import '../../core/utils/json_parse.dart';
import '../../core/widgets/error_retry.dart';
import '../../core/widgets/offline_banner.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statisticsStreamProvider);
    final districts = ref.watch(districtsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: OfflineBanner(
        child: RefreshIndicator(
          onRefresh: () => ref.read(syncControllerProvider.notifier).syncNow(),
          child: stats.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => ErrorRetry(
              message: err.toString(),
              onRetry: () => ref.invalidate(statisticsStreamProvider),
            ),
            data: (items) {
              return districts.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (err, _) => ErrorRetry(
                  message: err.toString(),
                  onRetry: () => ref.invalidate(districtsStreamProvider),
                ),
                data: (districtList) {
                  if (items.isEmpty) {
                    return ListView(
                      children: const [
                        SizedBox(height: 120),
                        EmptyState(
                          icon: Icons.bar_chart_outlined,
                          message: 'No statistics yet. Sync when online.',
                        ),
                      ],
                    );
                  }

                  final districtMap = {
                    for (final d in districtList) d.id: d,
                  };
                  final latestYear = items
                      .map((s) => s.seasonYear)
                      .reduce((a, b) => a > b ? a : b);
                  final yearStats = items
                      .where((s) => s.seasonYear == latestYear)
                      .toList();

                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Text(
                        'Cases in $latestYear',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 220,
                        child: _CasesBarChart(
                          stats: yearStats,
                          districtMap: districtMap,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'All records',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      const SizedBox(height: 8),
                      ...items.map((s) {
                        final district = districtMap[s.districtId];
                        final districtName = district != null
                            ? pickLocalizedText(
                                district.nameEn, district.nameNe)
                            : 'District ${s.districtId}';
                        return Card(
                          child: ListTile(
                            title: Text(districtName),
                            subtitle: Text(
                              'Season ${s.seasonYear} · Reported ${s.reportedAt}',
                            ),
                            trailing: Text(
                              '${s.caseCount}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                        );
                      }),
                    ],
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

class _CasesBarChart extends StatelessWidget {
  const _CasesBarChart({
    required this.stats,
    required this.districtMap,
  });

  final List<Statistic> stats;
  final Map<int, District> districtMap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final maxCases = stats
        .map((s) => s.caseCount)
        .fold<int>(0, (a, b) => a > b ? a : b);

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: (maxCases * 1.2).clamp(1, double.infinity).toDouble(),
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 32),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= stats.length) {
                  return const SizedBox.shrink();
                }
                final district = districtMap[stats[index].districtId];
                final label = district?.code ?? '${stats[index].districtId}';
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        barGroups: [
          for (var i = 0; i < stats.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: stats[i].caseCount.toDouble(),
                  color: scheme.primary,
                  width: 16,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
