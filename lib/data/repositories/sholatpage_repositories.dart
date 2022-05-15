import 'package:geocoding/geocoding.dart';
import 'package:muslim_daily/data/models/sholatpage_model.dart';
import 'package:muslim_daily/data/providers/sholatpage_providers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

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
      Position position = await sholatpageProvider.determinePosition();
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
      return null;
    }

    //  ambil data nama kota dari geocoding
    try {
      List<Placemark> placemark =
          await sholatpageProvider.getPlacemarks(latitude, longitude);
      city = placemark[0].subLocality ?? 'Tidak Diketahui';
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
      return null;
    }

    //  ambil data kode kota dari http
    try {
      cityCode = await sholatpageProvider.getCityCode(city, http.Client());
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
      return null;
    }

    //  ambil data waktu sholat dari http
    try {
      getSholatTimeOutput = await sholatpageProvider.getSholatTimes(
          cityCode, date, http.Client());
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
}
