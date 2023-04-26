import 'package:bloc_architecture_demo/home/bloc/weather_bloc.dart';
import 'package:bloc_architecture_demo/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (context) => WeatherBloc(),
        ),
      ],
      child: const MaterialApp(
        title: 'Bloc Architecture Demo',
        debugShowCheckedModeBanner: false,
        home: HomeView(),
      ),
    );
  }
}
