import 'package:geolocator/geolocator.dart';
import 'package:f_202110_firebase/domain/services/location.dart';

class GpsService implements LocationInterface {
  @override
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(); 
  }
}