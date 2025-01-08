abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final String? temperature;
  final String? condition;
  final String? iconUrl;

  WeatherLoadedState({
    required this.temperature,
    required this.condition,
    required this.iconUrl,
  });
}

class WeatherErrorState extends WeatherState {
  final String message;

  WeatherErrorState({required this.message});
}
