import 'package:flutter/material.dart';

import 'package:climate_app/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:climate_app/services/weather.dart';
import 'package:lottie/lottie.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}


class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();

    determinePosition();
    print("Init code is Run");
  }



  void determinePosition() async{

    var weatherData = await WeatherModel().getLocationData();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
    LocationScreen(decodedData: weatherData,)));
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
          child: Lottie.asset('animation/weather.json'),
        ),
    );}
}

