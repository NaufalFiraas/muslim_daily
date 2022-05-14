import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

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
}
