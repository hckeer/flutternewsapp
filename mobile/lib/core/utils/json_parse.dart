DateTime? parseApiDate(dynamic value) {
  if (value == null) return null;
  if (value is String) return DateTime.tryParse(value);
  if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
  return null;
}

DateTime parseApiDateRequired(dynamic value) {
  return parseApiDate(value) ?? DateTime.now();
}

String pickLocalizedText(String? en, String? ne) {
  if (en != null && en.isNotEmpty) return en;
  if (ne != null && ne.isNotEmpty) return ne;
  return '';
}
