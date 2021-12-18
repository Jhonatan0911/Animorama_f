import 'package:geolocator/geolocator.dart';
import 'package:f_202110_firebase/data/services/geolocation.dart';

class LocationManager {
  final gpsService = GpsService();

  Future<Position> getCurrentLocation() async {
    return await gpsService.getCurrentLocation(); 
  }
}