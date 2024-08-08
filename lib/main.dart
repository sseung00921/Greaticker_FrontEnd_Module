import 'package:flutter/material.dart';
import 'package:greaticker/common/layout/default_layout.dart';

void main() {
  runApp(const MyApp(language: "EN"));
}

class MyApp extends StatelessWidget {
  final String language;

  const MyApp({
    required this.language,
    super.key
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultLayout(
        key: Key('DefaultLayout'),
        language: language,
      ),
    );
  }
}


