
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Env {
  Env();
  static Env? _instance;
  
  factory Env.instance() {
    _instance ??= kDebugMode ? _EnvDebug() : _EnvRelease();
    return _instance!;
  }
  static const _tokenKey = 'HF_TOKEN';
  static const _baseUrlKey = 'BASE_URL';
  String get baseUrl => dotenv.env[_baseUrlKey] ?? '';
  String get apiKey => dotenv.env[_tokenKey] ??  '';
}

class _EnvDebug extends Env {
    _EnvDebug() : super();

    @override
    String get baseUrl => dotenv.env[Env._baseUrlKey] ?? '';

    @override
    String get apiKey => dotenv.env[Env._tokenKey] ?? '';
}

class _EnvRelease extends Env {
  _EnvRelease() : super();


    @override
    String get baseUrl => const String.fromEnvironment(Env._baseUrlKey);

    @override
    String get apiKey => const String.fromEnvironment(Env._tokenKey);
}