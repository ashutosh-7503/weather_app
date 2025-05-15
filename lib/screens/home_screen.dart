import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherServices _weatherServices = WeatherServices();

  final TextEditingController _controller = TextEditingController(
    text: 'Kanpur',
  );

  bool _isLoading = false;

  Weather? _weather;

  Future<Weather> getWeatherForKanpur() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final weather = await _weatherServices.fetchWeather('kanpur');
      // print(weather);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Wrong city input',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
    return _weather!;
  }

  void _getWeather() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final weather = await _weatherServices.fetchWeather(_controller.text);
      // print(weather);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Wrong city input',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient:
              _weather != null &&
                      _weather!.description.toLowerCase().contains('rain')
                  ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey, Colors.blueGrey],
                  )
                  : _weather != null &&
                      _weather!.description.toLowerCase().contains('clear')
                  ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.orangeAccent, Colors.blueAccent],
                  )
                  : _weather != null &&
                      _weather!.description.toLowerCase().contains('snow')
                  ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFFFFF), // Pure white
                      Color(0xFFE0F7FA), // Very light icy blue
                      Color(0xFFB2EBF2), // Light cyan
                    ],
                  )
                  : const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey, Colors.lightBlueAccent],
                  ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 20),

                Text(
                  'Weather App',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                SizedBox(height: 20),

                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Enter city name',
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: const Color.fromRGBO(
                      189,
                      189,
                      189,
                      1,
                    ).withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: _getWeather,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(
                      189,
                      189,
                      189,
                      1,
                    ).withOpacity(0.5),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Get Weather',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                if (_isLoading)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),

                if (_weather != null) WeatherCard(weather: _weather!),

                // else
              ],
            ),
          ),
        ),
      ),
    );
  }
}
