import 'package:clima/services/networking.dart';
import 'package:clima/utilities/config.dart';
import 'package:clima/services/location.dart';
import 'package:geolocator/geolocator.dart';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    await Location.getPosition();
    Position userPosition = Location.acquiredPosition;
    NetworkHelper networkHelper =
        NetworkHelper('https://api.openweathermap.org/data/2.5/weather?'
            'lat=${userPosition.latitude.toString()}&'
            'lon=${userPosition.longitude.toString()}&'
            'appid=$kOpenWeatherApiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
