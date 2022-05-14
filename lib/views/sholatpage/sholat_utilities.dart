import 'package:flutter/material.dart';

class SholatUtilities {
  static List<Container> buildPraysContainers(List<String> prays) {
    return List.generate(
      prays.length,
      (index) {
        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(index == 0 ? 15 : 0),
              bottom: Radius.circular(index == prays.length - 1 ? 15 : 0),
            ),
            color: index % 2 != 0 ? Colors.white : Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                prays[index],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                ),
              ),
              const Text(
                '00 : 00',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static BoxShadow sholatBoxShadow = const BoxShadow(
    spreadRadius: 1,
    blurRadius: 3,
    offset: Offset(0, 1),
    color: Color(0x10000000),
  );

  static TextStyle textStyling({required double size, Color? color}) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w500,
      fontFamily: 'Roboto',
    );
  }
}
