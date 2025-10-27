
class Env {
  static const _tokenKey = 'HF_TOKEN';
  static const _baseUrlKey = 'BASE_URL';
  static String get baseUrl => const String.fromEnvironment(_baseUrlKey);
  static String get apiKey => const String.fromEnvironment(_tokenKey);
}