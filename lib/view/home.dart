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
  String capitalizeWord(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  String capitalizeEachWord(String input) {
    List<String> words = input.split(' ');

    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] =
            words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
      }
    }

    String result = words.join(' ');

    return result;
  }

  String? path;

  void changePath(String main) {
    switch (main) {
      case 'Clear':
        path = "assets/images/clear.png";
        break;

      case 'Rain':
        path = "assets/images/rain.png";
        break;

      case 'Snow':
        path = "assets/images/snow.png";
        break;

      case 'Clouds':
        path = "assets/images/cloud.png";
        break;

      case 'Haze':
        path = "assets/images/mist.png";
        break;

      default:
        path = "assets/images/not-found.png";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final wheaterViewModel = Provider.of<WeatherViewModel>(context);
    void onPress(String city) async {
      await wheaterViewModel.fetchWeather(city);
      if (wheaterViewModel.weather != null) {
        changePath(wheaterViewModel.weather!.main);
      }
      setState(() {
        path;
      });
    }

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                height: 55.0,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 99, 99, 99),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 0.5))
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.location_on,
                        color: Color.fromARGB(255, 8, 90, 0),
                        size: 25,
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: city,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0.0),
                          hintText: 'Search Location',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 151, 151, 151),
                            fontSize: 17.0,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          onPress(city.text);
                        },
                        child: const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (wheaterViewModel.loading)
                const CircularProgressIndicator()
              else if (wheaterViewModel.error.isNotEmpty)
                Text(wheaterViewModel.error)
              else if (wheaterViewModel.weather != null)
                Column(
                  children: [
                    Image.asset(
                      path ?? "assets/images/not-found.png",
                      height: 200,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      capitalizeWord(city.text),
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      capitalizeEachWord(wheaterViewModel.weather!.description),
                      style: const TextStyle(fontSize: 17),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.water,
                              size: 35,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                const Text(
                                  "Temp",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(wheaterViewModel.weather!.temp.toString())
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.air,
                              size: 35,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                const Text(
                                  "Wind",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(wheaterViewModel.weather!.wind.toString())
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                )
            ],
          )),
    );
  }
}
