import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'env/env.dart';

class InformationRetriever {
  final baseUrl = 'https://router.huggingface.co/v1/chat/completions';
  final _models = <String, String>{
    'mistralai': 'mistralai/Mistral-7B-Instruct-v0.2',
    'huihui-ai': 'huihui-ai/Qwen2.5-14B-Instruct-abliterated-v2:featherless-ai'
  };

  String getModel(String name) => _models[name] ?? _models['huihui-ai']!;

  String get defaultModel => getModel('huihui-ai');

  Map<String, String> get _headers => {
        'Authorization': 'Bearer ${Env.apiKey}',
        'Content-Type': 'application/json',
      };

  String _body(String prompt, {bool stream = false}) => jsonEncode({
        'model': defaultModel,
        'stream': stream,
        'messages': [
          {
            'role': 'user',
            'content': prompt,
          }
        ]
      });

  // ry {
  //       final res = await http.post(
  //         Uri.parse('https://router.huggingface.co/v1/chat/completions'),
  //         headers: {
  //           'Authorization': 'Bearer ${dotenv.env['HF_TOKEN']}',
  //           'Content-Type': 'application/json',
  //         },
  //         body: jsonEncode({
  //           'model': 'mistralai/Mistral-7B-Instruct-v0.2:featherless-ai',
  //           'messages': [{'role': 'user', 'content': prompt}],
  //         }),
  //       );
  //
  //       if (res.statusCode == 200) {
  //         final data = jsonDecode(res.body);

  Stream<String> getInformationFromDataAsStream(String prompt) async* {
    final request = http.Request(
      'POST',
      Uri.parse('https://router.huggingface.co/v1/chat/completions'),
    )
      ..headers.addAll(_headers)
      ..body = _body(prompt, stream: true);

    final response = await request.send();

    await for (final chunk in response.stream
        .transform(utf8.decoder)
        .transform(const LineSplitter())) {
      if (chunk.startsWith('data:')) {
        final data = chunk.substring(5).trim();
        if (data == '[DONE]') break;

        final json = jsonDecode(data);
        final delta = json['choices'][0]['delta'];
        if (delta != null && delta['content'] != null) {
          yield delta['content'] as String;
        }
      }
    }
  }

  Future<String> getInformationFromData(String prompt) async {
    final response = await http.post(Uri.parse(baseUrl),
        headers: _headers, body: _body(prompt));
    return _handleResponse(response);
  }

  String _handleResponse(http.Response response) {
    if (response.statusCode == HttpStatus.ok) {
      return jsonDecode(response.body)['choices'][0]['message']['content'];
    }
    return 'Error ${response.statusCode}';
  }
}
