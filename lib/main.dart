import 'package:flutter/material.dart';
import 'package:muslim_daily/views/templatepage/template_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TemplatePage(),
    );
  }
}

