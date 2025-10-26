import 'package:flutter/material.dart';

class TwoColumnLayout extends StatefulWidget {
  const TwoColumnLayout({super.key});

  @override
  State<TwoColumnLayout> createState() => _TwoColumnLayoutState();
}

class _TwoColumnLayoutState extends State<TwoColumnLayout> {
  final leftController = TextEditingController();
  final rightController = TextEditingController();
  var _isLoading = false;

  void buttonPressed() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void dispose() {
    leftController.dispose();
    rightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daten ▶️ Informationen')),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // const Text('Daten'),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                  height: 500.0,
                  child: TextField(
                    controller: leftController,
                    // keyboardType: TextInputType.text,
                    // minLines: 1, // Normal textInputField will be displayed
                    // maxLines: 5, // When user presses enter it will adapt to it
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      // contentPadding: EdgeInsets.all(100),
                      hintText: 'Gib hier einige Daten ein',
                    ),
                    onSubmitted: (text) {},
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
                child: ElevatedButton(
                  onPressed: buttonPressed,
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
                  child: TextField(
                    readOnly: true,
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
