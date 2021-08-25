import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late Position userPosition;
  late double latitude;
  late double longitude;
  late Timer _timer;

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    _timer = new Timer(const Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(weatherData);
      }));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission are permanently denied, we '
          'cannot request permissions');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
