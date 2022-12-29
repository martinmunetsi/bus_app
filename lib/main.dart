import 'package:flutter/material.dart';
import 'language.dart';

void main() {
  runApp(TransMetroApp());
}

class TransMetroApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LanguagePage(title: 'TransMetro Bus'),
    );
  }
}

