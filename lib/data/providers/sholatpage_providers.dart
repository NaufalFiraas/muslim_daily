import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class SholatpageProvider {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are enabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are denied forever. Please check your device settings!');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<List<Placemark>> getPlacemarks(
      double latitude, double longitude) async {
    try {
      return await placemarkFromCoordinates(latitude, longitude);
    } catch (e, stackTrace) {
      print(stackTrace.toString());
      throw Exception('Error get placemarks');
    }
  }

  Future<String> getCityCode(String city, http.Client client) async {
    Uri url = Uri.parse(
        'https://api.myquran.com/v1/sholat/kota/cari/$city');
    http.Response response = await client.get(url);
    if (response.statusCode >= 400) {
      throw Exception('Gagal mengambil info kode kota');
    }
    String cityCode = json.decode(response.body)['data'][0]['id'];
    return cityCode;
  }

  Future<Map<String, dynamic>> getSholatTimes(
      String cityCode, DateTime date, http.Client client) async {
    int year = date.year;
    int month = date.month;
    int day = date.day;
    Uri url = Uri.parse(
        'https://api.myquran.com/v1/sholat/jadwal/$cityCode/$year/$month/$day');
    http.Response response = await client.get(url);
    if (response.statusCode >= 400) {
      throw Exception('Gagal mengambil info waktu sholat');
    }
    Map<String, dynamic> responseDecoded =
        json.decode(response.body)['data']['jadwal'];
    Map<String, dynamic> sholatTimes = {
      'tanggal': responseDecoded['tanggal'],
      'waktu': {
        'Imsak': responseDecoded['imsak'],
        'Shubuh': responseDecoded['subuh'],
        'Syuruk': responseDecoded['terbit'],
        'Dhuhur': responseDecoded['dzuhur'],
        'Ashar': responseDecoded['ashar'],
        'Maghrib': responseDecoded['maghrib'],
        "Isya'": responseDecoded['isya'],
      }
    };

    return sholatTimes;
  }
}
