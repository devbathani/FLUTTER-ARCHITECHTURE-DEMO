import 'package:bloc_architecture_demo/home/model/weather_model.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitialise extends WeatherState {
  final WeatherModel weatherModel;
  const WeatherInitialise({required this.weatherModel});
}

class WeatherLoadingState extends WeatherState {}

class WeatherErrorState extends WeatherState {}
