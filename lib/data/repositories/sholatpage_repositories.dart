import 'dart:async';

import 'package:flutter_compass/flutter_compass.dart';
import 'package:muslim_daily/data/models/arah_kiblat.dart';
import 'package:muslim_daily/data/models/sholatpage_model.dart';
import 'package:muslim_daily/data/providers/sholatpage_providers.dart';

class SholatpageRepositories {
  final SholatpageProvider sholatpageProvider;
  final DateTime date;

  const SholatpageRepositories(this.sholatpageProvider, this.date);

  Future<SholatpageModel?> getSholatData() async {
    double latitude;
    double longitude;
    String city;
    String cityCode;
    Map<String, dynamic> getSholatTimeOutput;

    //  ambil data latitude longitude dari geolocator
    try {
      Map<String, dynamic> position =
          await sholatpageProvider.determinePosition();
      latitude = position['latitude'];
      longitude = position['longitude'];
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
      return null;
    }

    //  ambil data nama kota dari geocoding
    try {
      String? placemark =
          await sholatpageProvider.getPlacemarks(latitude, longitude);
      city = placemark ?? 'Tidak Diketahui';
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
      return null;
    }

    //  ambil data kode kota dari http
    try {
      cityCode = await sholatpageProvider.getCityCode(city);
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
      return null;
    }

    //  ambil data waktu sholat dari http
    try {
      getSholatTimeOutput =
          await sholatpageProvider.getSholatTimes(cityCode, date);
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
      return null;
    }

    SholatpageModel sholatpageModel = SholatpageModel(
      city: city,
      date: getSholatTimeOutput['tanggal'],
      sholatTime: getSholatTimeOutput['waktu'],
    );
    return sholatpageModel;
  }

  Future<ArahKiblat?> getKiblatDirection() async {
    double latitude;
    double longitude;
    String city;
    double kiblatDirection;

    try {
      Map<String, dynamic> position =
          await sholatpageProvider.determinePosition();
      latitude = position['latitude'];
      longitude = position['longitude'];
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
      return null;
    }

    try {
      city = await sholatpageProvider.getPlacemarks(latitude, longitude) ??
          'Lokasi tidak diketahui';
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
      return null;
    }

    try {
      kiblatDirection = await sholatpageProvider.getKiblatDirection(city);
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
      return null;
    }

    return ArahKiblat(city, kiblatDirection);
  }
}
