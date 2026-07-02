/// API base URL — override at build/run time for wireless debugging:
/// `flutter run --dart-define=API_BASE_URL=http://192.168.x.x:3000/api`
class ApiConfig {
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3000/api',
  );

  /// Static uploads are served from the host root, not under `/api`.
  static String get uploadsBaseUrl {
    if (baseUrl.endsWith('/api')) {
      return baseUrl.substring(0, baseUrl.length - 4);
    }
    return baseUrl;
  }
}
