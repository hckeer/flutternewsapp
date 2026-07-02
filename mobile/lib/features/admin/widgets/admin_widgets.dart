import 'package:flutter/material.dart';

class AdminStatusChip extends StatelessWidget {
  const AdminStatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (color, label) = switch (status) {
      'published' => (scheme.primaryContainer, 'Published'),
      'archived' => (scheme.surfaceContainerHighest, 'Archived'),
      _ => (scheme.secondaryContainer, 'Draft'),
    };
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      backgroundColor: color,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
    );
  }
}

Future<bool?> confirmDelete(BuildContext context, String label) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete?'),
      content: Text('Delete $label? This cannot be undone.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}

class BilingualFields extends StatelessWidget {
  const BilingualFields({
    super.key,
    required this.titleEnController,
    required this.titleNeController,
    this.titleLabel = 'Title',
    this.bodyEnController,
    this.bodyNeController,
    this.bodyLabel = 'Body',
    this.summaryEnController,
    this.summaryNeController,
    this.showSummary = false,
    this.bodyMaxLines = 6,
  });

  final TextEditingController titleEnController;
  final TextEditingController titleNeController;
  final String titleLabel;
  final TextEditingController? bodyEnController;
  final TextEditingController? bodyNeController;
  final String bodyLabel;
  final TextEditingController? summaryEnController;
  final TextEditingController? summaryNeController;
  final bool showSummary;
  final int bodyMaxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('$titleLabel (English)',
            style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 4),
        TextField(
          controller: titleEnController,
          decoration: InputDecoration(hintText: '$titleLabel in English'),
        ),
        const SizedBox(height: 12),
        Text('$titleLabel (Nepali)',
            style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 4),
        TextField(
          controller: titleNeController,
          decoration: InputDecoration(hintText: '$titleLabel in Nepali'),
        ),
        if (showSummary && summaryEnController != null) ...[
          const SizedBox(height: 16),
          Text('Summary (English)',
              style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 4),
          TextField(
            controller: summaryEnController,
            maxLines: 2,
          ),
          const SizedBox(height: 12),
          Text('Summary (Nepali)',
              style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 4),
          TextField(
            controller: summaryNeController,
            maxLines: 2,
          ),
        ],
        if (bodyEnController != null && bodyNeController != null) ...[
          const SizedBox(height: 16),
          Text('$bodyLabel (English)',
              style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 4),
          TextField(
            controller: bodyEnController,
            maxLines: bodyMaxLines,
            decoration: const InputDecoration(hintText: 'Markdown supported'),
          ),
          const SizedBox(height: 12),
          Text('$bodyLabel (Nepali)',
              style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 4),
          TextField(
            controller: bodyNeController,
            maxLines: bodyMaxLines,
            decoration: const InputDecoration(hintText: 'Markdown supported'),
          ),
        ],
      ],
    );
  }
}

class AdminScaffold extends StatelessWidget {
  const AdminScaffold({
    super.key,
    required this.title,
    required this.body,
    this.fab,
  });

  final String title;
  final Widget body;
  final Widget? fab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: body,
      floatingActionButton: fab,
    );
  }
}
