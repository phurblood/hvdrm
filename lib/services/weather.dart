import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';

const apiKey = "58c3a57c8aea4206801bc51cab04d6fc";
const openWeatherMapUrl = "https://api.openweathermap.org/data/2.5/weather";
class WeatherModel {
  Future<dynamic> getCityWeather(String city)async{
    NetworkHelper networkHelper = NetworkHelper("$openWeatherMapUrl?q=$city&appid=$apiKey&units=metric");
    var weatherData = await networkHelper.getData();
    return weatherData;
  }


  Future<dynamic> getLocationWeather() async{
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper("$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longtitude}&appid=$apiKey&units=metric");
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
  

  String getWeatherIcon(condition) {
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
      return '⛅';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return ' ŞANSLISIN!\n BUGÜN HAVA ÇOK GÜZEL\n😍';
    } else if (temp > 20) {
      return ' BUGÜN GEZMEK İÇİN HARİKA BİR YER\n🎉 ';
    } else if (temp < 10) {
      return ' İÇİN SANIRIM BİRAZ SOĞUK BİR GÜN\n🥶';
    } else {
      return ' İÇİN YELEK GİYMEK FENA FİKİR DEĞİL\n🤔';
    }
  }
}
