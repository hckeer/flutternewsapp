import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/providers/app_providers.dart';
import '../../core/providers/content_providers.dart';
import '../../core/utils/json_parse.dart';
import '../../core/widgets/error_retry.dart';
import '../../core/widgets/offline_banner.dart';

class ContactsScreen extends ConsumerWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(contactsStreamProvider);
    final districts = ref.watch(districtsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Emergency contacts')),
      body: OfflineBanner(
        child: RefreshIndicator(
          onRefresh: () => ref.read(syncControllerProvider.notifier).syncNow(),
          child: contacts.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => ErrorRetry(
              message: err.toString(),
              onRetry: () => ref.invalidate(contactsStreamProvider),
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
                          icon: Icons.local_hospital_outlined,
                          message: 'No contacts yet. Sync when online.',
                        ),
                      ],
                    );
                  }

                  final districtMap = {
                    for (final d in districtList) d.id: d,
                  };

                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final contact = items[index];
                      final name =
                          pickLocalizedText(contact.nameEn, contact.nameNe);
                      final district = contact.districtId != null
                          ? districtMap[contact.districtId!]
                          : null;
                      final districtName = district != null
                          ? pickLocalizedText(
                              district.nameEn, district.nameNe)
                          : null;

                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(_iconForType(contact.contactType)),
                          ),
                          title: Text(name.isNotEmpty ? name : contact.phone),
                          subtitle: Text([
                            _labelForType(contact.contactType),
                            ?districtName,
                            contact.phone,
                          ].whereType<String>().join(' · ')),
                          trailing: IconButton(
                            icon: const Icon(Icons.phone),
                            onPressed: () => _callPhone(contact.phone),
                          ),
                          onTap: () => _callPhone(contact.phone),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  IconData _iconForType(String type) {
    return switch (type) {
      'hotline' => Icons.phone_in_talk,
      'hospital' => Icons.local_hospital,
      'clinic' => Icons.medical_services,
      _ => Icons.contact_phone,
    };
  }

  String _labelForType(String type) {
    return switch (type) {
      'hotline' => 'Hotline',
      'hospital' => 'Hospital',
      'clinic' => 'Clinic',
      _ => 'Contact',
    };
  }

  Future<void> _callPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
