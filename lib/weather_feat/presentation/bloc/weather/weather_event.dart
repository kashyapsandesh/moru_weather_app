abstract class WeatherEvent {}

class FetchWeatherByLatLong extends WeatherEvent {
  final double latitude;
  final double longitude;

  FetchWeatherByLatLong({required this.latitude, required this.longitude});
}

class FetchWeatherByCityName extends WeatherEvent {
  final String cityName;

  FetchWeatherByCityName({required this.cityName});
}
class FetchWeatherDataBySavedLocation extends WeatherEvent {

}
class UpdateSavedLocation extends WeatherEvent {
  final String cityName;

  UpdateSavedLocation({required this.cityName});
}
