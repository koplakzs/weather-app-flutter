import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheater_app/view-model/wheater.view-model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController city = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final wheaterViewModel = Provider.of<WeatherViewModel>(context);

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: city,
          ),
          ElevatedButton(
              onPressed: () {
                wheaterViewModel.fetchWeather(city.text);
              },
              child: const Text("test")),
          if (wheaterViewModel.loading)
            const Center(child: CircularProgressIndicator())
          else if (wheaterViewModel.error.isNotEmpty)
            Text(wheaterViewModel.error)
          else if (wheaterViewModel.weather != null)
            Column(
              children: [
                Text('Status = ${wheaterViewModel.weather!.main}'),
                Text('Description = ${wheaterViewModel.weather!.description}'),
                Text('Temp = ${wheaterViewModel.weather!.temp}'),
                Text('Speed = ${wheaterViewModel.weather!.wind}')
              ],
            )
        ],
      )),
    );
  }
}
