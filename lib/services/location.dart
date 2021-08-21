import 'package:geolocator/geolocator.dart';

class Location {
  static late Position acquiredPosition;

  static Future<void> getPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      acquiredPosition = position;
    } catch (e) {
      print(e);
    }
  }
}
