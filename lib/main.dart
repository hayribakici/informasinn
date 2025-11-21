import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:informasinn/home.dart';

void main() async {
  await _loadEnv();
  runApp(MaterialApp(
    title: "Daten ▶️ Informationen",
    theme: ThemeData(
      colorScheme: const ColorScheme.light(primary: Colors.blue),
    ),
    home: const TwoColumnLayout(),
  ));
}

Future<void> _loadEnv() async {
  if (kDebugMode) {
    await dotenv.load(fileName: ".env.dev");
  }
}
