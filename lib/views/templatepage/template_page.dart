import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class TemplatePage extends StatefulWidget {
  const TemplatePage({Key? key}) : super(key: key);

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  int index = 0;

  List<String> titles = [
    'Sholat',
    "Qur'an",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const Drawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Text(
          titles[index],
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
            color: Color(0xFF00C537),
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: index,
        animationDuration: const Duration(milliseconds: 400),
        height: 60,
        backgroundColor: Colors.transparent,
        color: const Color(0xFF00C537),
        items: [
          Image.asset(
            'assets/images/kabah.png',
            height: 35,
            width: 35,
          ),
          Image.asset(
            'assets/images/quran.png',
            height: 35,
            width: 35,
          ),
        ],
        onTap: (index) => setState(() {
          this.index = index;
        }),
      ),
    );
  }
}
