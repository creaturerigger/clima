import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart';
import 'package:clima/utilities/config.dart';
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late Position userPosition;
  late Response weatherResponse;

  Future<void> getLocation() async {
    await Location.getPosition();
    userPosition = Location.acquiredPosition;
    print("Longitude: ${userPosition.longitude}, "
        "Latitude: ${userPosition.latitude}");
  }

  Future<void> getData(double lat, double lon, String apiKey) async {
    Response response = await get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${lat.toString()}&"
        "lon=${lon.toString()}&appid=$apiKey"));
    if (response.statusCode == 200) {
      String data = response.body;
      Map<String, dynamic> jsonFormatted = jsonDecode(data);
      int id = jsonFormatted["weather"][0]["id"];
      double temp = jsonFormatted["main"]["temp"];
      String cityName = jsonFormatted["name"];

      print("The id of $cityName is ${id.toString()} and temperature is "
          "${temp.toString()}");
    } else {
      print(response.statusCode);
    }
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

  void loadData() async {
    await getLocation();
    var position = userPosition;
    await getData(position.latitude, position.longitude, kOpenWeatherApiKey);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
