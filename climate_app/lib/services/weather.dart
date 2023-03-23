import 'package:climate_app/services/networking.dart';
import 'package:climate_app/services/location.dart';
import 'package:flutter/material.dart';

class WeatherModel {
  static const apiKey = '7dd154eca4897af141f1c7678e37c5b4';
  String startUrl ='https://api.openweathermap.org/data/2.5/weather';

    Future<dynamic> getLocationDataByCity(cityName) async {
     String url ='https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
      NetworkHelper networkHelper = NetworkHelper(url);
      var weatherData = await networkHelper.getData();

      return weatherData;
    }

  Future<dynamic> getLocationData() async{
    Location location =Location();
    await location.getCurrentLocation();


    NetworkHelper networkHelper = NetworkHelper('$startUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
  // String getWeatherIcon(int? condition) {
  //   if (condition !< 300) {
  //     return '11d';
  //   } else if (condition < 400) {
  //     return '09d';
  //   } else if (condition < 600) {
  //     return '10d';
  //   } else if (condition < 700) {
  //     return '13d';
  //   } else if (condition < 800) {
  //     return '50d';
  //   } else if (condition == 800) {
  //     return '01d';
  //   } else if (condition <= 804) {
  //     return '02d';
  //   } else {
  //     return '01d';
  //   }
  // }

  String getMessage(int? temp) {
    if (temp !> 25) {
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