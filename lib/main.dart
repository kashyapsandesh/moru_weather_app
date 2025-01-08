import 'package:flutter/material.dart';
import 'package:moru_weather_app/core/di/service_locator.dart';
import 'package:moru_weather_app/core/root.dart';

void main() {
  setupServiceLocator();
  runApp(const Root());
}
