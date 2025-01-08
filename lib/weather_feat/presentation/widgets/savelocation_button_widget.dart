
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moru_weather_app/weather_feat/data/source/local/weather_storage.dart';
import 'package:moru_weather_app/weather_feat/presentation/bloc/weather/weather_bloc.dart';
import 'package:moru_weather_app/weather_feat/presentation/bloc/weather/weather_event.dart';

class SaveLocationButton extends StatelessWidget {
  const SaveLocationButton({
    super.key,
    required this.savedLocation,
  });

  final String? savedLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade400,
            Colors.blue.shade600
          ], // Gradient for button
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius:
            BorderRadius.circular(25), // Slightly smaller rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: () async {
          // Handle button press
          print('Save Location Button Pressed $savedLocation');
          if (savedLocation != null) {
            await WeatherStorage().saveLocation(savedLocation!);
            context.read<WeatherBloc>().add(FetchWeatherDataBySavedLocation());
            Fluttertoast.showToast(
                msg: "Location Saved Successfully ${savedLocation}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            Fluttertoast.showToast(
                msg: "Please Enter Location in Textfield",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        padding:
            EdgeInsets.zero, // Remove extra padding from the MaterialButton
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors
                    .blue.shade50, // Background color for the loyalty icon
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.loyalty, // Replace with a custom loyalty icon if needed
                color: Colors.blue, // Icon color
                size: 16, // Smaller icon size
              ),
            ),
            const SizedBox(width: 6), // Space between the icon and the text
            Text(
              "Save Location", // Points text
              style: TextStyle(
                color: Colors.white, // Text color
                fontSize: 12, // Smaller text size
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
