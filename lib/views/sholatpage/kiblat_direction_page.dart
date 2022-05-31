import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'sholat_utilities.dart';
import 'dart:math' as math;

class KiblatDirectionPage extends StatelessWidget {
  const KiblatDirectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Arah Kiblat',
          style: SholatUtilities.textStyling(
            size: 20,
            color: const Color(0xFF00C537),
          ),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: Center(
        child: Stack(
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

                if (snapshot.connectionState == ConnectionState.waiting) {
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
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: MediaQuery.of(context).size.width * 0.65,
                      ),
                      Transform.rotate(
                        angle: 294.2 * (math.pi / 180),
                        child: Image.asset(
                          'assets/images/kiblat_direction.png',
                          width: MediaQuery.of(context).size.width * 0.65,
                          height: MediaQuery.of(context).size.width * 0.65,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
