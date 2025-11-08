
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static const _tokenKey = 'HF_TOKEN';
  static const _baseUrlKey = 'BASE_URL';
  static String get baseUrl => dotenv.env[_baseUrlKey] ?? '';
  static String get apiKey => dotenv.env[_tokenKey] ??  '';
}