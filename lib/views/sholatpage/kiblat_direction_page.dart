import 'package:flutter/material.dart';
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
              width: 300,
              height: 300,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: math.pi * 0,
                  child: Image.asset(
                    'assets/images/compass.png',
                    // fit: BoxFit.fill,
                    width: 200,
                    height: 200,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
