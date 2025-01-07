import 'package:flutter/material.dart';
import 'package:moru_weather_app/onboard_feat/data/source/local/appfirsttimestatus_storage.dart';

class WeatherHome extends StatelessWidget {
  const WeatherHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                await AppFirstTimeStatusStorage().clearAppFirstTimeStatus();
              },
              child: Text("clear saved data")),
          Center(
            child: Text("Weather Home"),
          ),
        ],
      ),
    );
  }
}
