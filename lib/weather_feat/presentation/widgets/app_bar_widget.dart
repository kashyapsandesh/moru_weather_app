import 'package:flutter/material.dart';
import 'package:moru_weather_app/core/theme/colors/appcolors.dart';
import 'package:moru_weather_app/weather_feat/presentation/widgets/savelocation_button_widget.dart';

class WeatherAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? currentPlace;
  final VoidCallback onHelpPressed;

  const WeatherAppBar({
    super.key,
    required this.currentPlace,
    required this.onHelpPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: AppColors.lightBgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Moru Weather',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Get Real-Time Weather Updates with Moru',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 8,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          SaveLocationButton(
            savedLocation: currentPlace,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 30,
              child: IconButton(
                onPressed: onHelpPressed,
                icon: Icon(Icons.help),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}