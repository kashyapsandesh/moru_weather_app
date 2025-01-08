import 'package:flutter/material.dart';
import 'package:moru_weather_app/core/theme/colors/appcolors.dart';

class WeatherDisplay extends StatelessWidget {
  final String? iconUrl;
  final String? temperature;
  final String? condition;
  final String? location;

  const WeatherDisplay({
    super.key,
    required this.iconUrl,
    required this.temperature,
    required this.condition,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.network(
            "https:$iconUrl",
            height: 100,
            width: 100,
          ),
        ),
        Center(
          child: Text(
            '$temperature°C',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 50,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Text(
            condition ?? '',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Text(
            location ?? '',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}