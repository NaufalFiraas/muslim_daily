import 'package:flutter/material.dart';
import 'package:muslim_daily/blocs/sholatpage_blocs/add_sholat_time/add_sholat_time_bloc.dart';
import 'package:muslim_daily/data/providers/sholatpage_providers.dart';
import 'package:muslim_daily/data/repositories/sholatpage_repositories.dart';
import 'package:muslim_daily/views/sholatpage/sholat_utilities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SholatPage extends StatefulWidget {
  const SholatPage({Key? key}) : super(key: key);

  @override
  State<SholatPage> createState() => _SholatPageState();
}

class _SholatPageState extends State<SholatPage> {
  late final SholatpageProvider sholatpageProvider;
  late final SholatpageRepositories sholatpageRepo;
  late final DateTime date;

  @override
  void initState() {
    super.initState();
    date = DateTime.now();
    sholatpageProvider = SholatpageProvider();
    sholatpageRepo = SholatpageRepositories(sholatpageProvider, date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Builder(builder: (context) {
          AddSholatTimeBloc sholatTimeBloc =
              context.watch<AddSholatTimeBloc>();

          if (sholatTimeBloc.state is AddSholatTimeLoading) {
            return const Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: Color(0xFF00C537),
                ),
              ),
            );
          } else if (sholatTimeBloc.state is AddSholatTimeFailed) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Gagal Mengambil Data Waktu Sholat'),
                  Text(
                      'Periksa koneksi internet dan setting gps anda, lalu restart aplikasi'),
                ],
              ),
            );
          } else {
            AddSholatTimeSuccess sholatTimeSuccess =
                sholatTimeBloc.state as AddSholatTimeSuccess;

            return SingleChildScrollView(
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
                    sholatTimeSuccess.sholatpageModel.city,
                    style: SholatUtilities.textStyling(
                      size: 22,
                      color: const Color(0xFF00C537),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    sholatTimeSuccess.sholatpageModel.date,
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
                      children: SholatUtilities.buildPraysContainers(
                          sholatTimeSuccess.sholatpageModel),
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
