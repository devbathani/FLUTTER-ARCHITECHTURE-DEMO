import 'package:flutter/material.dart';
import 'package:mvc_architecture_demo/home/view/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MVC Arch Demo',
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
