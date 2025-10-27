import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:informasinn/data_to_information.dart';
import 'package:url_launcher_web/url_launcher_web.dart' as web;

class TwoColumnLayout extends StatefulWidget {
  const TwoColumnLayout({super.key});

  @override
  State<TwoColumnLayout> createState() => _TwoColumnLayoutState();
}

class _TwoColumnLayoutState extends State<TwoColumnLayout> {
  final leftController = TextEditingController();
  final rightController = TextEditingController();
  final retriever = InformationRetriever();

  var _isLoading = false;

  void _submitPrompt() {
    setLoading(true);
    rightController.text = '';
    var stream = retriever.getInformationFromDataAsStream(_preparePrompt());
    stream.listen((answerChunk) {
      setLoading(false);
      rightController.text += answerChunk;
    }, onError: (e) {
      rightController.text = 'Hoppla! Ein Fehler ist unterlaufen (${e.toString()}';
      setLoading(false);
    });
  }

  String _preparePrompt() {
    return 'Gib mir bitte Informationen zu den folgenden Daten: ${leftController.text}}. Sei so kurz und knapp wie möglich.';
  }

  @override
  void dispose() {
    leftController.dispose();
    rightController.dispose();
    super.dispose();
  }

  void setLoading(bool loading) {
    if (loading == _isLoading) {
      return;
    }
    setState(() {
      _isLoading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daten ▶️ Informationen')),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('Powered by '),
          RichText(
            text: TextSpan(
              text: 'Huggingface',
              style: const TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await web.UrlLauncherPlugin().launch('https://hugginface.co');
                },
            ),
          ),
          const Text(' and '),
          RichText(
            text: TextSpan(
              text: retriever.defaultModel,
              style: const TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await web.UrlLauncherPlugin().launch(
                      'https://huggingface.co/${retriever.defaultModel}');
                },
            ),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                  height: 500.0,
                  child: TextField(
                    controller: leftController,
                    enabled: !_isLoading,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Gib hier einige Daten ein',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => leftController.clear(),
                      ),
                    ),
                    onSubmitted: (_) async => _submitPrompt(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              const SizedBox(height: 25),
              Center(
                child: TextButton(
                  onPressed: _submitPrompt,
                  child: const Icon(Icons.keyboard_arrow_right_sharp),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text('Information'),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
                  height: 500.0,
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : TextField(
                          readOnly: true,
                          maxLines: 1000,
                          controller: rightController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Information aus den Daten',
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
