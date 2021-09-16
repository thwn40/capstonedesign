
import 'package:geolocator/geolocator.dart';

class geoLocatorService {
  Future<Position> getLocation() async {
    var geolocator = Geolocator();
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        );
  }
}
