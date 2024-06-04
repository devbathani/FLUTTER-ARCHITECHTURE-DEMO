import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:getx_architecture_demo/app/data/models/weather_model.dart';
import 'package:getx_architecture_demo/app/data/respository/home_repo.dart';

class HomeController extends GetxController {
  //This function will get the current Latitude and Longitude for futhur API call
  RxString lat = "".obs;
  RxString log = "".obs;
  getLocation() async {
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

    await Geolocator.getCurrentPosition().then(
      (value) {
        lat = value.latitude.toString().obs;
        log = value.longitude.toString().obs;
        update();
        getWeatheData();
      },
    );
  }

  //This function will fetch the current weather data as per the Latitude and Longitude
  final _homeRepository = HomeRepository();
  WeatherModel? weatherModel;
  Future getWeatheData() async {
    final response = await _homeRepository.getWeatherData(
        latitude: lat.value, longitude: log.value);
    if (response.statusCode == 200) {
      weatherModel = weatherModelFromJson(response.body);
      update();
    } else {
      print("Error in fetching Data");
    }
  }

  @override
  void onInit() {
    getLocation();
    super.onInit();
  }
}
