import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:moru_weather_app/core/configs/routes/route_name.dart';
import 'package:moru_weather_app/core/theme/colors/appcolors.dart';
import 'package:moru_weather_app/weather_feat/data/source/local/weather_service.dart';
import 'package:moru_weather_app/weather_feat/data/source/local/weather_storage.dart';
import 'package:moru_weather_app/weather_feat/presentation/bloc/location/location_bloc.dart';
import 'package:moru_weather_app/weather_feat/presentation/bloc/location/location_state.dart';
import 'package:moru_weather_app/weather_feat/presentation/bloc/weather/weather_bloc.dart';
import 'package:moru_weather_app/weather_feat/presentation/bloc/weather/weather_event.dart';
import 'package:moru_weather_app/weather_feat/presentation/bloc/weather/weather_state.dart';
import 'package:moru_weather_app/weather_feat/presentation/widgets/app_bar_widget.dart';
import 'package:moru_weather_app/weather_feat/presentation/widgets/weather_display_widget.dart';
import 'package:moru_weather_app/weather_feat/presentation/widgets/search_section_widget.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  String? currentPlace;
  bool isLoading = false;
  bool isLocationSaved = false;
  final TextEditingController locationController = TextEditingController();
  final WeatherService weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(FetchWeatherDataBySavedLocation());
  }

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
                Navigator.of(context).pop();
                await Geolocator.openLocationSettings();
              },
              child: Text('Open Settings'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
    final WeatherService weatherService = GetIt.instance<WeatherService>();
    return Scaffold(
      body: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state is LocationPermissionDeniedForeverState) {
            _showLocationPermissionDialog(context);
          }
        },
        builder: (context, locationState) {
          return SafeArea(
            child: Scaffold(
              appBar: WeatherAppBar(
                currentPlace: currentPlace,
                onHelpPressed: () {
                  Navigator.pushReplacementNamed(
                      context, AppRoutesName.appIntro);
                },
              ),
              body: Container(
                color: AppColors.lightBgColor,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    BlocConsumer<WeatherBloc, WeatherState>(
                      listener: (context, weatherState) {
                        if (weatherState is WeatherLoadedState) {
                          isLocationSaved = weatherState.isLocationSaved;
                        }
                      },
                      builder: (context, weatherState) {
                        if (weatherState is WeatherErrorState) {
                          return Center(
                            child: Text(
                              ' ${weatherState.message}',
                            ),
                          );
                        }
                        if (weatherState is WeatherLoadedState) {
                          return Column(
                            children: [
                              WeatherDisplay(
                                iconUrl: weatherState.iconUrl,
                                temperature: weatherState.temperature,
                                condition: weatherState.condition,
                                location: weatherState.location,
                              ),
                              SearchSection(
                                locationController: locationController,
                                onLocationChanged: (value) {
                                  setState(() {
                                    currentPlace =
                                        value?.isEmpty ?? true ? null : value;
                                  });
                                },
                                onSearchPressed: () async {
                                  final savedLocation = await weatherService
                                      .checkWhetherLocationSaved();
                                  if (savedLocation ?? false) {
                                    context
                                        .read<WeatherBloc>()
                                        .add(FetchWeatherDataBySavedLocation());
                                  } else {
                                    context.read<WeatherBloc>().add(
                                        FetchWeatherByCityName(
                                            cityName: currentPlace!));
                                  }
                                },
                                isLocationSaved: isLocationSaved,
                              ),
                              const SizedBox(height: 20),
                            ],
                          );
                        }
                        return const CupertinoActivityIndicator();
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await weatherService.clearLocation();
                        context
                            .read<WeatherBloc>()
                            .add(FetchWeatherDataBySavedLocation());
                        setState(() {
                          isLocationSaved = false;
                        });
                      },
                      child: Text("Clear Location"),
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
