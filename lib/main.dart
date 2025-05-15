import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
void main() async {
   await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}