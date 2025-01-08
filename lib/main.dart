import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:moru_weather_app/core/di/service_locator.dart';
import 'package:moru_weather_app/core/root.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(milliseconds: 3000), () {});
  FlutterNativeSplash.remove();
  setupServiceLocator();

  runApp(const Root());
}
