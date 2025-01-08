import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:moru_weather_app/core/theme/colors/appcolors.dart';
import 'package:moru_weather_app/onboard_feat/data/source/local/appfirsttimestatus_storage.dart';
import 'package:moru_weather_app/weather_feat/data/model/weather_response_byplace_model.dart';
import 'package:moru_weather_app/weather_feat/data/repositories_impl/get_weather_details_repo_impl.dart';
import 'package:moru_weather_app/weather_feat/data/source/local/weather_storage.dart';
import 'package:moru_weather_app/weather_feat/presentation/bloc/location/location_bloc.dart';
import 'package:moru_weather_app/weather_feat/presentation/bloc/location/location_event.dart';
import 'package:moru_weather_app/weather_feat/presentation/bloc/location/location_state.dart';
import 'package:moru_weather_app/weather_feat/presentation/bloc/weather/weather_bloc.dart';
import 'package:moru_weather_app/weather_feat/presentation/bloc/weather/weather_event.dart';
import 'package:moru_weather_app/weather_feat/presentation/bloc/weather/weather_state.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  String? currentPlace;

  String? temperature;
  String? condition;
  String? iconUrl;
  bool isLoading = false;
  GetWeatherDetailsRepoImpl weatherHome = GetWeatherDetailsRepoImpl();

  @override
  void initState() {
    try {
      context.read<WeatherBloc>().add(FetchWeatherDataBySavedLocation());
      print("Weather Home: FetchWeatherDataBySavedLocation event dispatched");
      print("Weather Home");
    } catch (e) {
      print("Error in initState: $e");
    }
    super.initState();
  }

  // Function to show the dialog
  void _showLocationPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Permission Denied Forever'),
          content: Text(
              'You have permanently denied location permission. To enable it, please go to settings and allow access.'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                // Open the location settings
                await Geolocator.openLocationSettings();
              },
              child: Text('Open Settings'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) async {
        if (state is LocationPermissionDeniedForeverState) {
          _showLocationPermissionDialog(context);
        }
      },
      builder: (context, locationState) {
        return SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(150),
              child: Container(
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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Container(
              color: AppColors.lightBgColor,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  // Weather State Section
                  BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, weatherState) {
                      if (weatherState is WeatherErrorState) {
                        return Center(
                          child: Text(
                            'Error fetching weather details: ${weatherState.message}',
                          ),
                        );
                      }
                      if (weatherState is WeatherLoadedState) {
                        return Column(
                          children: [
                            Center(
                              child: Image.network(
                                "https:${weatherState.iconUrl}",
                                height: 100,
                                width: 100,
                              ),
                            ),
                            Center(
                              child: Text(
                                '${weatherState.temperature}°C',
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
                                weatherState.condition.toString(),
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
                      return const CupertinoActivityIndicator();
                    },
                  ),
                  const SizedBox(height: 20),

                  // Search Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Enter City Name',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onChanged: (value) {
                              currentPlace = value;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            debugPrint('Searching for: $currentPlace');
                            context.read<WeatherBloc>().add(
                                FetchWeatherByCityName(cityName: currentPlace!));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Search',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

}
