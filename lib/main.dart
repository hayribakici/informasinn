import 'package:flutter/material.dart';
import 'package:informasinn/home.dart';

void main() async {
  runApp(MaterialApp(
    title: "Daten ▶️ Informationen",
    theme: ThemeData(
      colorScheme: const ColorScheme.light(primary: Colors.blue),
    ),
    home: const TwoColumnLayout(),
  ));
}
