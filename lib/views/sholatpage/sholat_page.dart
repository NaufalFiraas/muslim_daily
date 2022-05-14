import 'package:flutter/material.dart';
import 'package:muslim_daily/views/sholatpage/sholat_utilities.dart';

class SholatPage extends StatefulWidget {
  const SholatPage({Key? key}) : super(key: key);

  @override
  State<SholatPage> createState() => _SholatPageState();
}

class _SholatPageState extends State<SholatPage> {
  final List<String> prays = [
    'Imsak',
    'Shubuh',
    'Syuruk',
    'Dhuhur',
    'Ashar',
    'Magrhib',
    "Isya'",
  ];

  late final List<Container> praysContainers;

  @override
  void initState() {
    super.initState();
    praysContainers = SholatUtitlies.buildPraysContainers(prays);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 32,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0x2000C537),
                      boxShadow: const [
                        BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 1),
                          color: Color(0x10000000),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '01 : 10 : 35',
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          'Menjelang Sholat Maghrib',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                            color: Color(0xFF727272),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Mohon Maaf',
                                style: TextStyle(
                                  color: Color(0xFF00C537),
                                ),
                              ),
                              content: const Text(
                                  'Fitur ini masih belum tersedia.. :('),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            );
                          });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 32,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0x2000C537),
                        boxShadow: const [
                          BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 1),
                            color: Color(0x10000000),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/kabah.png',
                            height: 40,
                            width: 40,
                          ),
                          const Text(
                            'Arah Kiblat',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                              color: Color(0xFF727272),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Kota Malang',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  color: Color(0xFF00C537),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Kamis, 12 Mei 2022',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                      color: Color(0x10000000),
                    ),
                  ],
                  color: const Color(0x2000C537),
                ),
                child: Column(
                  children: praysContainers,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
