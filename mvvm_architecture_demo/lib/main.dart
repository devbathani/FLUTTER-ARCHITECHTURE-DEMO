import 'package:flutter/material.dart';
import 'package:mvvm_architecture_demo/home/view/home_view.dart';
import 'package:mvvm_architecture_demo/list_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: List.from(providers),
      child: const MaterialApp(
        title: 'MVVM Arch Demo',
        debugShowCheckedModeBanner: false,
        home: HomeView(),
      ),
    );
  }
}
