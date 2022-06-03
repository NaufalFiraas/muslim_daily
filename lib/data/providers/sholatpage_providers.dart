import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_daily/data/models/icon_reminder_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SholatpageProvider {
  Future<Map<String, dynamic>> determinePosition() async {
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

    Position position = await Geolocator.getCurrentPosition();
    return {
      'latitude': position.latitude,
      'longitude': position.longitude,
    };
  }

  Future<String?> getPlacemarks(double latitude, double longitude) async {
    try {
      List<Placemark> placemark =
      await placemarkFromCoordinates(latitude, longitude);
      return placemark[0].subAdministrativeArea;
    } catch (e, stackTrace) {
      print(e.toString());
      print(stackTrace.toString());
      throw Exception('Error get placemarks');
    }
  }

  Future<String> getCityCode(String city, [http.Client? optionalClient]) async {
    String onlyCity = city.split(' ')[1].toLowerCase();
    http.Client client = optionalClient ?? http.Client();
    Uri url =
    Uri.parse('https://api.myquran.com/v1/sholat/kota/cari/$onlyCity');
    http.Response response = await client.get(url);
    if (response.statusCode >= 400) {
      throw Exception('Gagal mengambil info kode kota');
    }
    List<dynamic> responseData =
    json.decode(response.body)['data'] as List<dynamic>;
    Map<String, dynamic> selectedMap = {};

    //  Telusuri data (Map<String, dynamic>)
    for (Map<String, dynamic> element in responseData) {
      //  Split value dari key 'lokasi'
      String lokasi = element['lokasi'] as String;
      List<String> splittedLokasi = lokasi.split(' ');
      //  Jika panjang setelah di split > 1
      if (splittedLokasi.length > 1) {
        if (splittedLokasi[1].toLowerCase() == onlyCity) {
          selectedMap = element;
          break;
        }
      }
      // Jika panjang setelah di split < 1
      else {
        if (splittedLokasi[0].toLowerCase() == onlyCity) {
          selectedMap = element;
          break;
        }
      }
    }

    return selectedMap['id'];
  }

  Future<Map<String, dynamic>> getSholatTimes(String cityCode, DateTime date,
      [http.Client? optionalClient]) async {
    http.Client client = optionalClient ?? http.Client();
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

  Future<double> getKiblatDirection(String location,
      [http.Client? optionalClient]) async {
    http.Client client = optionalClient ?? http.Client();
    String onlyCity = location.split(' ')[1].toLowerCase();
    Uri url = Uri.parse('https://time.siswadi.com/qibla/?address=malang');
    http.Response response = await client.get(url);
    if (response.statusCode >= 400) {
      throw Exception('Gagal mengambil data lokasi kiblat');
    }
    Map<String, dynamic> data = json.decode(response.body)['data'];
    double kabahDirection = data['derajat'] as double;
    return kabahDirection;
  }

  Future<void> saveIconReminderStatus(int index, bool status,
      [SharedPreferences? optionalPref]) async {
    SharedPreferences pref = optionalPref ?? await SharedPreferences.getInstance();
    await pref.setBool('$index', status);
  }

  Future<bool?> getIconReminder(int index, [SharedPreferences? optionalPref]) async {
    SharedPreferences pref = optionalPref ?? await SharedPreferences.getInstance();
    return pref.getBool('$index');
  }
}
