import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
  @override
  List<Object> get props => [];
}

class WeatherInitizalize extends WeatherEvent {}

class WeatherError extends WeatherEvent {}
