import 'package:openrouter_api/openrouter_api.dart';

import 'env/env.dart';

class InformationRetriever {
  final client = OpenRouter.inference(
    key: Env.apiKey,
    baseUrl: 'https://router.huggingface.co/v1',
  );

  final _models = <String, String>{
    'mistralai': 'mistralai/Mistral-7B-Instruct-v0.2:featherless-ai',
    'huihui-ai': 'huihui-ai/Qwen2.5-14B-Instruct-abliterated-v2:featherless-ai'
  };

  String getModel(String name) => _models[name] ?? _models['huihui-ai']!;

  String get defaultModel => getModel('huihui-ai');

  Stream<String> retrieveAsStream(String prompt) {
    return client
        .streamCompletion(
      messages: _createMessage(prompt),
      modelId: defaultModel,
    )
        .map((result) {
      return result.choices.first.content;
    });
  }

  Future<String> getInformationFromData(String prompt) async {
    try {
      var response = await client.getCompletion(
        messages: _createMessage(prompt),
        modelId: defaultModel,
      );
      return response.choices.first.content;
    } on Exception catch (e, s) {
      print("API Error during stream: ${e.toString()} $s");
      return "error";
    }
  }

  List<LlmMessage> _createMessage(String prompt) => [
        LlmMessage.user(LlmMessageContent.text(prompt)),
      ];
}
