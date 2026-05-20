import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String selectedCity = "Peshawar";

  String temperature = "";

  String cityName = "";

  Future<void> getWeather(String city) async {
    const apiKey = "8e662d5fb28d4a76a7a52954261305";

    final url = "http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        cityName = data['location']['name'];
        temperature = data['current']['temp_c'].toString();
      });
    } else {
      cityName = "City not found";
      temperature = "";
    }
  }

  final List<String> cities = [
    "Lahore",
    "Karachi",
    "Islamabad",
    "Faisalabad",
    "Gujranwala",
    "Quetta",
    "Peshawar",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              Text(
                "Weather App",
                style: TextStyle(fontSize: 40, color: Colors.black),
              ),
              30.verticalSpace,
              DropdownButtonFormField<String>(
                initialValue: selectedCity,
                decoration: InputDecoration(border: OutlineInputBorder()),
                items: cities.map((city) {
                  return DropdownMenuItem(value: city, child: Text(city));
                }).toList(),

                onChanged: (newValue) {
                  setState(() {
                    selectedCity = newValue!;
                    getWeather(selectedCity);
                  });
                },
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  getWeather(selectedCity);
                },
                child: const Text("Get Weather"),
              ),

              const SizedBox(height: 30),

              Text(
                cityName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text("$temperature °C", style: const TextStyle(fontSize: 40)),
            ],
          ),
        ),
      ),
    );
  }
}
