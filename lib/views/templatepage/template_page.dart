import 'package:flutter/material.dart';

class TemplatePage extends StatelessWidget {
  const TemplatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: const Text(
          'Sholat',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
            color: Color(0xFF00C537),
          ),
        ),
      ),
      body: Container(),
    );
  }
}
