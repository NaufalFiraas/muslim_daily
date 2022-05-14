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
    praysContainers = SholatUtilities.buildPraysContainers(prays);
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
                      boxShadow: [SholatUtilities.sholatBoxShadow],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '01 : 10 : 35',
                          style: SholatUtilities.textStyling(size: 22),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          'Menjelang Sholat Maghrib',
                          style: SholatUtilities.textStyling(
                            size: 16,
                            color: const Color(0xFF727272),
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
                        boxShadow: [SholatUtilities.sholatBoxShadow],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/kabah.png',
                            height: 40,
                            width: 40,
                          ),
                          Text(
                            'Arah Kiblat',
                            style: SholatUtilities.textStyling(
                              size: 16,
                              color: const Color(0xFF727272),
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
              Text(
                'Kota Malang',
                style: SholatUtilities.textStyling(
                  size: 22,
                  color: const Color(0xFF00C537),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Kamis, 12 Mei 2022',
                style: SholatUtilities.textStyling(size: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [SholatUtilities.sholatBoxShadow],
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
