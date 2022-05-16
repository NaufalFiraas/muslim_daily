import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_daily/blocs/sholatpage_blocs/add_sholat_time/add_sholat_time_bloc.dart';
import 'package:muslim_daily/data/providers/sholatpage_providers.dart';
import 'package:muslim_daily/data/repositories/sholatpage_repositories.dart';
import 'package:muslim_daily/views/quranpage/quran_page.dart';
import 'package:muslim_daily/views/sholatpage/sholat_page.dart';

class TemplatePage extends StatefulWidget {
  const TemplatePage({Key? key}) : super(key: key);

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  late SholatpageRepositories sholatpageRepo;
  late SholatpageProvider sholatpageProvider;
  late DateTime date;
  int index = 0;

  final List<String> titles = [
    'Sholat',
    "Qur'an",
  ];

  final List<Widget> pages = [
    SholatPage(),
    QuranPage(),
  ];

  @override
  void initState() {
    super.initState();
    date = DateTime.now();
    sholatpageProvider = SholatpageProvider();
    sholatpageRepo = SholatpageRepositories(sholatpageProvider, date);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddSholatTimeBloc(sholatpageRepo)
            ..add(const AddSholatTimeEvent()),
        ),
      ],
      child: Scaffold(
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
        body: pages[index],
        bottomNavigationBar: CurvedNavigationBar(
          index: index,
          animationDuration: const Duration(milliseconds: 400),
          height: 55,
          backgroundColor: Colors.transparent,
          color: const Color(0xFF00C537),
          items: [
            Image.asset(
              'assets/images/kabah.png',
              height: 30,
              width: 30,
            ),
            Image.asset(
              'assets/images/quran.png',
              height: 30,
              width: 30,
            ),
          ],
          onTap: (index) => setState(() {
            this.index = index;
          }),
        ),
      ),
    );
  }
}
