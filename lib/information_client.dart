import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'env/env.dart';

abstract class InformationRetriever {
  final _baseUrl = Env.baseUrl;
  final _models = <String, String>{
    'mistralai': 'mistralai/Mistral-7B-Instruct-v0.2',
    'huihui-ai': 'huihui-ai/Qwen2.5-14B-Instruct-abliterated-v2:featherless-ai'
  };

  String getModel(String name) => _models[name] ?? _models['huihui-ai']!;
  String get defaultModel => getModel('huihui-ai');

  InformationRetriever();

  factory InformationRetriever.instance() {
    if (kReleaseMode) {
      return _InformationRetrieverRelease();
    }
    return _InformationRetrieverDebug();
  }

  Map<String, String> get _headers;
  String _body(String prompt);

  Future<String> getInformationFromData(String prompt) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: _headers,
      body: _body(prompt),
    );
    return _handleResponse(response);
  }

  String _handleResponse(http.Response response) {
    if (response.statusCode == HttpStatus.ok) {
      try {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'] ?? '';
      } catch (_) {
        return response.body;
      }
    }
    return 'Error ${response.statusCode}';
  }
}

class _InformationRetrieverRelease extends InformationRetriever {
  @override
  Map<String, String> get _headers =>
      {HttpHeaders.contentTypeHeader: ContentType.json.mimeType};

  @override
  String _body(String prompt) => jsonEncode({'prompt': prompt});
}

class _InformationRetrieverDebug extends InformationRetriever {
  @override
  Map<String, String> get _headers => {
    HttpHeaders.authorizationHeader: 'Bearer ${Env.apiKey}',
    HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
  };

  @override
  String _body(String prompt) => jsonEncode({
    'model': defaultModel,
    'stream': false,
    'messages': [
      {'role': 'user', 'content': prompt}
    ]
  });
}
