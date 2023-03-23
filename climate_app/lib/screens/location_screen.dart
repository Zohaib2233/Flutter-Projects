import 'package:flutter/material.dart';
import 'package:climate_app/utils/constants.dart';
import 'package:climate_app/services/weather.dart';
import 'package:climate_app/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key,this.decodedData});

  final decodedData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weatherModel = WeatherModel();
  String? cityName;
  String? weatherDescription;
  int? temperature;
  int? condition;
  String? icon;

  String? weatherIcon;
  String? weatherMessage;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.decodedData);
  }

  void updateUI(dynamic weatherData){
    setState(() {
      cityName=weatherData['name'];
      weatherDescription = weatherData['weather'][0]['description'];
      icon = weatherData['weather'][0]['icon'];
      condition = weatherData['weather'][0]['id'];
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      weatherMessage = weatherModel.getMessage(temperature);
      print(icon);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFEA9527),
              Color(0xFFAE783B),
              Color(0x10EA9527),

            ]
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async{
                        print(cityName);
                        var weatherData = await WeatherModel().getLocationData();
                        updateUI(weatherData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () async{
                            var typeName = await Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            const CityScreen()));
                            if(typeName != null){
                              var weatherData = await weatherModel.getLocationDataByCity(typeName);
                              updateUI(weatherData);
                              print(typeName);
                            }

                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Image.network('http://openweathermap.org/img/wn/$icon@2x.png',fit: BoxFit.fill,
                 
                ),
                Column(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '$temperature°',
                          style: kTempTextStyle,
                        ),
                        Text('${weatherDescription }'),

                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "$weatherMessage in $cityName!",
                      textAlign: TextAlign.center,
                      style: kMessageTextStyle,
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

