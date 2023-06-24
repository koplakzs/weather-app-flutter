import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:wheater_app/view-model/view-model-weather.dart';
import 'package:wheater_app/view/home.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherViewModel(),
      child: const MaterialApp(
        home: Home(),
      ),
    );
  }
}
