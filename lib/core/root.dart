import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moru_weather_app/core/configs/routes/route_name.dart';
import 'package:moru_weather_app/core/configs/routes/routes.dart';
import 'package:moru_weather_app/core/theme/apptheme.dart';
import 'package:moru_weather_app/onboard_feat/data/source/local/appfirsttimestatus_storage.dart';
import 'package:moru_weather_app/onboard_feat/presentation/bloc/appinfo_bloc.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late Future<bool>
      _firstTimeStatusFuture; // Yo  variable late delcare gareko kinaki initState() ma initialize garepaxi future ma balla yesko value thaha hunxa so.

  @override
  void initState() {
    super.initState();
    // Start the future to check first-time status
    _firstTimeStatusFuture = _checkFirstTimeStatus();
  }

  // Method to check the first-time status
  Future<bool> _checkFirstTimeStatus() async {
    bool firstTimeStatus =
        await AppFirstTimeStatusStorage().readAppFirstTimeStatus();
    print('First Time Status: $firstTimeStatus');
    print(firstTimeStatus.runtimeType);
    return firstTimeStatus;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future:
          _firstTimeStatusFuture, // Use the future to determine the initial screen
      builder: (context, snapshot) {
        // Check if the future is completed
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Optionally, show a simple placeholder widget while waiting (no loader)
          return const SizedBox.shrink(); // Empty widget, waiting
        }

        // If future is done, proceed with routing
        if (snapshot.hasData) {
          bool isFirstTime = snapshot.data!;

          return MultiBlocProvider(
            providers: [
              BlocProvider<AppinfoBloc>(
                create: (context) => AppinfoBloc(),
              ),
            ],
            child: MaterialApp(
              title: 'Moru Weather App',
              themeMode: ThemeMode.system,
              theme: AppTheme.lightTheme,
              initialRoute: isFirstTime
                  ? AppRoutesName
                      .appIntro // Show splash screen (appIntro) for first time
                  : AppRoutesName
                      .weatherHome, // After onboarding, go to home page (weatherHome)
              onGenerateRoute: Routes.generateRoute,
            ),
          );
        }

        // If there's an error, return an error screen or handle it accordingly
        return const Center(child: Text('Error loading first-time status'));
      },
    );
  }
}
