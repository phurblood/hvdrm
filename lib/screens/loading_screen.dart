import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

String konum;

class _LoadingScreenState extends State<LoadingScreen> {
  void initState() {
    super.initState();
    getLocationData();
    getImageRandom();
  }

  bool inErrorState = false;
  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    try {
      var weatherData = await weatherModel.getLocationWeather();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
           return LocationScreen(
            locationWeather: weatherData,
          );
        }),
      );
    } catch (e) {
      setState(() {
        inErrorState = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 15.0,
            ),
            Container(
              child: Image.asset("images/sslogo.png", height: 96, width: 96),
            ),
            SizedBox(
              height: 7.0,
            ),
            Text("S K Y B E R S P A C E"),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                "Hava Durumu",
                style: kNormalSizeText.copyWith(
                  fontSize: 12.0,
                  color: Colors.lightBlueAccent,
                ),
              ),
            ),
            SizedBox(
              height: 7.0,
            ),
            if (inErrorState) ...{
              FlatButton(
                child: Text("Yeniden Dene"),
                onPressed: () {
                  setState(() {
                    inErrorState = false;
                  });
                  getLocationData();
                },
              )
            } else
              SpinKitDoubleBounce(
                color: Colors.white,
                size: 100.0,
              ),
          ],
        ),
      ),
    );
  }
}
