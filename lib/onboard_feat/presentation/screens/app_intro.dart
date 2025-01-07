import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moru_weather_app/core/configs/routes/route_name.dart';
import 'package:moru_weather_app/core/configs/strings/app_strings.dart';
import 'package:moru_weather_app/onboard_feat/presentation/bloc/appinfo_bloc.dart';
import 'package:moru_weather_app/onboard_feat/presentation/bloc/appinfo_event.dart';

import '../bloc/appinfo_state.dart';

class AppIntro extends StatefulWidget {
  const AppIntro({super.key});

  @override
  State<AppIntro> createState() => _AppIntroState();
}

class _AppIntroState extends State<AppIntro> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    context.read<AppinfoBloc>().add(AppinfoCompleteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppinfoBloc, AppinfoState>(listener: (context, state) {
        if (state is AppinfoCompleteState) {
          // Navigate to the next screen
          Navigator.of(context).pushNamed(AppRoutesName.weatherHome);
        }
      }, builder: (context, state) {
        return Stack(
          children: [
            // Background Image
            // Background Image (Full Width and Height)
            Positioned.fill(
              child: Image.asset(
                'lib/assets/moru_appinfo_bg.png',
                fit: BoxFit
                    .cover, // Stretches the image to cover the entire screen
              ),
            ),
            // Content inside the frame
            // Content inside the frame
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title Text
                  Text(
                    appInfo_heading_txtview,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Adjust color for contrast
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Buttons
                  ElevatedButton(
                    onPressed: () {
                      // Handle "Get Started" button press
                      context.read<AppinfoBloc>().add(AppinfoFirstTimeEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, // Text color
                      backgroundColor: Colors.orange, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Rounded edges
                      ),
                    ),
                    child: Text(appInfo_btn_skip_txt),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
