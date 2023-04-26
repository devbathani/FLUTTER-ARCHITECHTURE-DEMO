import 'package:bloc/bloc.dart';

import 'package:bloc_architecture_demo/home/bloc/weather_event.dart';
import 'package:bloc_architecture_demo/home/bloc/weather_state.dart';
import 'package:bloc_architecture_demo/home/model/weather_model.dart';
import 'package:bloc_architecture_demo/home/respository/home_repo.dart';
import 'package:geolocator/geolocator.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  String lat = "";
  String log = "";
  final HomeRepository _homeRepository = HomeRepository();
  WeatherModel? weatherModel;
  WeatherBloc() : super(WeatherLoadingState()) {
    on<WeatherEvent>((event, emit) async {
      if (event is WeatherInitizalize) {
        //This function will get the current Latitude and Longitude for futhur API call
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
          (value) async {
            lat = value.latitude.toString();
            log = value.longitude.toString();
            final response = await _homeRepository.getWeatherData(
                latitude: lat, longitude: log);
            if (response.statusCode == 200) {
              weatherModel = weatherModelFromJson(response.body);
            } else {
              emit(WeatherErrorState());
            }
          },
        );
        emit(WeatherInitialise(weatherModel: weatherModel!));
      }
    });
  }
}
