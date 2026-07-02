bool hasAtLeastOneLanguage(String? a, String? b) {
  return (a != null && a.trim().isNotEmpty) ||
      (b != null && b.trim().isNotEmpty);
}

String? emptyToNull(String? value) {
  if (value == null || value.trim().isEmpty) return null;
  return value.trim();
}

class AdminValidators {
  static const statuses = ['draft', 'published', 'archived'];
  static const contactTypes = ['hotline', 'hospital', 'clinic', 'other'];

  static String? validateSlug(String? slug) {
    if (slug == null || slug.trim().isEmpty) {
      return 'Slug is required';
    }
    return null;
  }

  static String? validatePublishableContent({
    required String status,
    String? titleEn,
    String? titleNe,
    String? bodyEn,
    String? bodyNe,
  }) {
    if (status != 'published') return null;
    if (!hasAtLeastOneLanguage(titleEn, titleNe)) {
      return 'At least one title (English or Nepali) is required to publish';
    }
    if (!hasAtLeastOneLanguage(bodyEn, bodyNe)) {
      return 'At least one body (English or Nepali) is required to publish';
    }
    return null;
  }

  static String? validateActiveContact({
    required bool isActive,
    String? nameEn,
    String? nameNe,
  }) {
    if (!isActive) return null;
    if (!hasAtLeastOneLanguage(nameEn, nameNe)) {
      return 'At least one name (English or Nepali) is required for active contacts';
    }
    return null;
  }

  static String? validateDistrict({
    required String? code,
    required String? provinceEn,
  }) {
    if (code == null || code.trim().isEmpty) return 'Code is required';
    if (provinceEn == null || provinceEn.trim().isEmpty) {
      return 'Province (English) is required';
    }
    return null;
  }

  static String? validateStatistic({
    required int? districtId,
    required int? seasonYear,
    required int? caseCount,
    required String? reportedAt,
  }) {
    if (districtId == null) return 'District is required';
    if (seasonYear == null) return 'Season year is required';
    if (caseCount == null || caseCount < 0) {
      return 'Case count must be 0 or greater';
    }
    if (reportedAt == null || reportedAt.trim().isEmpty) {
      return 'Reported date is required';
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.trim().isEmpty) return 'Phone is required';
    return null;
  }
}
