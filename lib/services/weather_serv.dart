import 'location_serv.dart';
import 'package:weather_app/services/network_serv.dart';

//TODO ApiKey
//you need to apikey from openweathermap with free
const apiKey = 'your apikey here';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const sevenDaysWeatherMapURL = 'https://api.openweathermap.org/data/2.5/onecall';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location
            .longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }


  String getDuringDay(int durings) {
    if (durings < 300) {
      return 'Fırtınalı';
    } else if (durings < 500) {
      return 'Yer yer yağışlı';
    } else if (durings < 600) {
      return 'Yağmurlu';
    } else if (durings < 700) {
      return 'Karlı';
    } else if (durings < 800) {
      return 'Sisli';
    } else if (durings == 800) {
      return 'Açık';
    } else {
      return 'Bulutlu';
    }
  }


  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌪 ';
    } else if (condition < 500) {
      return '🌦';
    } else if (condition < 600) {
      return '⛈️';
    } else if (condition < 700) {
      return '❄️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else {
      return '☁️‍';
    }
  }
}
