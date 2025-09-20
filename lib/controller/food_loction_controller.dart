import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? currentPosition;
  String error = '';

  Future<void> getCurrentLocation() async {
    // await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        error = 'Location service disabled.';
        notifyListeners();
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          error = 'Location permissions denied';
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        error = 'Location permissions are permanently denied,';
        notifyListeners();
        return;
      }

      currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      error = '';
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }
}
