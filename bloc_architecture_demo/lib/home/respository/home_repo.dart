import 'dart:developer';

import 'package:http/http.dart' as http;

class HomeRepository {
  Future<http.Response> getWeatherData(
      {required String latitude, required String longitude}) async {
    final response = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=05fdaa09f4cac3887a5a831acf4fbfba"),
    );
    log("Weather Data : ${response.body}");
    return response;
  }
}
