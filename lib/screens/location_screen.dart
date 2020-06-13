import 'dart:math';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

int picNumber;

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;
  String message;
  bool loading = false;
  int condition;
 
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      setState(() {
        message = "Konum verileri alınamıyor.";
        temperature = 0;
      });
    } else {
      setState(
        () {
          var temp = weatherData["main"]["temp"];
          temperature = temp.toInt();
          var cond = weatherData["weather"][0]["id"];
          condition = cond.toInt();
          weatherIcon = weatherModel.getWeatherIcon(condition);
          cityName = weatherData["name"];
          weatherMessage = weatherModel.getMessage(temperature);
          message = " $cityName" + weatherMessage;
        },
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/$picNumber.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.45), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      var weatherData =
                          await weatherModel.getLocationWeather().timeout(
                                Duration(
                                  seconds: 10,
                                ),
                              );
                      updateUI(weatherData);
                      setState(
                        () {
                          loading = false;
                        },
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.near_me,
                          size: 50.0,
                        ),
                        Text(
                          "Konum",
                          style: kNormalSizeText,
                        ),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName =
                          await Navigator.pushNamed(context, "city");

                      if (typedName != null) {
                        setState(() {
                          loading = true;
                        });
                        var weatherData = await weatherModel
                            .getCityWeather(typedName)
                            .timeout(
                              Duration(seconds: 10),
                            );
                        updateUI(weatherData);
                        setState(() {
                          loading = false;
                        });
                      }
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.location_city,
                          size: 50.0,
                        ),
                        Text(
                          "Şehir",
                          style: kNormalSizeText,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              if (loading) ...{
                Column(
                  children: <Widget>[
                    SpinKitDoubleBounce(
                      color: Colors.white,
                    ),
                    Text(
                      "Yükleniyor..",
                      style: kNormalSizeText,
                    ),
                  ],
                )
              } else ...{
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "$temperature°",
                          style: kTempTextStyle,
                        ),
                        Text(
                          weatherIcon,
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: kMessageTextStyle,
                  ),
                ),
              },
              Container(
                height: 70.0,
                width: double.infinity,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

getImageRandom() {
  picNumber = Random().nextInt(14);
  print(picNumber);
}