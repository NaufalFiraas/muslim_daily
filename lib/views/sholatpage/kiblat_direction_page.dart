import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:muslim_daily/blocs/sholatpage_blocs/arah_kiblat/arah_kiblat_cubit.dart';
import 'package:muslim_daily/data/providers/sholatpage_providers.dart';
import 'package:muslim_daily/data/repositories/sholatpage_repositories.dart';
import 'sholat_utilities.dart';
import 'dart:math' as math;

class KiblatDirectionPage extends StatefulWidget {
  const KiblatDirectionPage({Key? key}) : super(key: key);

  @override
  State<KiblatDirectionPage> createState() => _KiblatDirectionPageState();
}

class _KiblatDirectionPageState extends State<KiblatDirectionPage> {
  late SholatpageProvider sholatpageProvider;
  late SholatpageRepositories sholatpageRepo;
  late DateTime date;

  @override
  void initState() {
    super.initState();
    date = DateTime.now();
    sholatpageProvider = SholatpageProvider();
    sholatpageRepo = SholatpageRepositories(sholatpageProvider, date);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArahKiblatCubit(sholatpageRepo)..getArahKiblat(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) {
            ArahKiblatState arahKiblatState =
                context.watch<ArahKiblatCubit>().state;
            if (arahKiblatState is ArahKiblatLoading) {
              return const Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: Color(0xFF00C537),
                  ),
                ),
              );
            } else if (arahKiblatState is ArahKiblatError) {
              return Center(
                child: Text(
                  arahKiblatState.message,
                  style: SholatUtilities.textStyling(
                    size: 16,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              arahKiblatState as ArahKiblatLoaded;

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Arah Kiblat',
                      style: SholatUtilities.textStyling(
                        size: 25,
                        color: const Color(0xFF00C537),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 20, 10, 50),
                          child: Text(
                            'Lokasi:',
                            style: SholatUtilities.textStyling(
                              size: 20,
                              color: const Color(0xFF00C537),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 20, 20, 50),
                          child: Text(
                            arahKiblatState.arahKiblat.cityName,
                            style: SholatUtilities.textStyling(
                              size: 20,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/images/compass_outer.png',
                          // fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.width * 0.9,
                        ),
                        StreamBuilder<CompassEvent>(
                          stream: FlutterCompass.events,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  'Gagal mengambil arah',
                                  style: SholatUtilities.textStyling(
                                    size: 16,
                                    color: Colors.black54,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: Color(0xFF00C537),
                                  ),
                                ),
                              );
                            }

                            double? direction = snapshot.data!.heading;

                            if (direction == null) {
                              return Center(
                                child: Text(
                                  'Perangkat tidak memiliki sensor',
                                  style: SholatUtilities.textStyling(
                                    size: 16,
                                    color: Colors.black54,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }

                            return Transform.rotate(
                              angle: (direction * (math.pi / 180) * -1),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/compass.png',
                                    // fit: BoxFit.fill,
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    height: MediaQuery.of(context).size.width *
                                        0.65,
                                  ),
                                  Transform.rotate(
                                    angle: arahKiblatState
                                            .arahKiblat.kiblatDirection *
                                        (math.pi / 180),
                                    child: Image.asset(
                                      'assets/images/kiblat_direction.png',
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.65,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
