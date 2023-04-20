import 'package:geolocator/geolocator.dart';
import 'package:mvc_architecture_demo/home/model/weather_model.dart';
import 'package:mvc_architecture_demo/home/respository/home_repo.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HomeViewController extends ControllerMVC {
  factory HomeViewController() => _this ??= HomeViewController._();
  HomeViewController._();
  static HomeViewController? _this;

  String lat = "";
  String log = "";
  //This function will fetch the current weather data as per the Latitude and Longitude
  final _homeRepository = HomeRepository();
  WeatherModel? weatherModel;
  Future<WeatherModel> getWeatherData() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.checkPermission();
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
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
//This function will get the current Latitude and Longitude for futhur API call
    await Geolocator.getCurrentPosition().then(
      (value) {
        lat = value.latitude.toString();
        log = value.longitude.toString();
      },
    );
    final response =
        await _homeRepository.getWeatherData(latitude: lat, longitude: log);

    return weatherModelFromJson(response.body);
  }
}
