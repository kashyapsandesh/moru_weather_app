import 'package:flutter/material.dart';
import 'package:moru_weather_app/core/configs/routes/route_name.dart';
import 'package:moru_weather_app/onboard_feat/presentation/screens/app_intro.dart';
import 'package:moru_weather_app/weather_feat/presentation/weather_home.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /// App Intro
      case AppRoutesName.appIntro:
        return MaterialPageRoute(builder: (context) => const AppIntro());

      case AppRoutesName.weatherHome:
        return MaterialPageRoute(builder: (context) => const WeatherHome());

      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text("No Route Generated"),
            ),
          );
        });
    }
  }
}
