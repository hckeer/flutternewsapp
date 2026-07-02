import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin panel')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Manage content',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          _AdminNavCard(
            icon: Icons.article_outlined,
            title: 'Articles',
            subtitle: 'Prevention guides & awareness',
            onTap: () => context.push('/admin/articles'),
          ),
          _AdminNavCard(
            icon: Icons.newspaper_outlined,
            title: 'News',
            subtitle: 'Outbreak updates & alerts',
            onTap: () => context.push('/admin/news'),
          ),
          _AdminNavCard(
            icon: Icons.bar_chart_outlined,
            title: 'Statistics',
            subtitle: 'Case counts by district',
            onTap: () => context.push('/admin/statistics'),
          ),
          _AdminNavCard(
            icon: Icons.map_outlined,
            title: 'Districts',
            subtitle: 'Reference districts',
            onTap: () => context.push('/admin/districts'),
          ),
          _AdminNavCard(
            icon: Icons.local_hospital_outlined,
            title: 'Contacts',
            subtitle: 'Hotlines & hospitals',
            onTap: () => context.push('/admin/contacts'),
          ),
          _AdminNavCard(
            icon: Icons.perm_media_outlined,
            title: 'Media',
            subtitle: 'Upload images & PDFs',
            onTap: () => context.push('/admin/media'),
          ),
        ],
      ),
    );
  }
}

class _AdminNavCard extends StatelessWidget {
  const _AdminNavCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
