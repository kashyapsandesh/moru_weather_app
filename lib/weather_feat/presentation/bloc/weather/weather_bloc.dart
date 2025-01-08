import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:moru_weather_app/weather_feat/data/repositories_impl/get_weather_details_repo_impl.dart';
import 'package:moru_weather_app/weather_feat/data/source/local/weather_storage.dart';
import 'package:moru_weather_app/weather_feat/presentation/bloc/weather/weather_event.dart';
import 'package:moru_weather_app/weather_feat/presentation/bloc/weather/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherDetailsRepoImpl weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherInitialState()) {
    on<FetchWeatherByLatLong>(_fetchWeatherByLatLong);
    on<FetchWeatherByCityName>(_fetchWeatherByCityName);
    on<FetchWeatherDataBySavedLocation>(_onFetchWeatherDataBySavedLocation);
  }

  void _fetchWeatherByLatLong(
      FetchWeatherByLatLong event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoadingState());
      final weather = await weatherRepository.getWeatherDetailsByLatLong(
          event.latitude.toString(), event.longitude.toString());
      emit(WeatherLoadedState(
        temperature: weather.current?.tempC.toString() ?? '',
        condition: weather.current?.condition?.text ?? '',
        iconUrl: weather.current?.condition?.icon ?? '',
      ));
    } catch (e) {
      emit(WeatherErrorState(message: "Error fetching weather details: $e"));
    }
  }

  void _fetchWeatherByCityName(
      FetchWeatherByCityName event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoadingState());
      print('City Name: ${event.cityName}');
      final weather =
          await weatherRepository.getWeatherDetailsByPlaceName(event.cityName);
      emit(WeatherLoadedState(
        temperature: weather.current?.tempC.toString() ?? '',
        condition: weather.current?.condition?.text ?? '',
        iconUrl: weather.current?.condition?.icon ?? '',
      ));
    } catch (e) {
      emit(WeatherErrorState(message: "Error fetching weather details: $e"));
    }
  }

  Future<void> _onFetchWeatherDataBySavedLocation(
    FetchWeatherDataBySavedLocation event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoadingState());

    try {
      final savedLocation = await WeatherStorage().readLocation();
      if (savedLocation != null) {
        // Fetch weather data by saved location
        final weatherData =
            await weatherRepository.getWeatherDetailsByPlaceName(savedLocation);

        emit(WeatherLoadedState(
          temperature: weatherData.current?.tempC.toString(),
          condition: weatherData.current?.condition?.text,
          iconUrl: weatherData.current?.condition?.icon,
        ));
      } else {
        // Fetch weather data by user's current location
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        final weatherData = await weatherRepository.getWeatherDetailsByLatLong(
          position.latitude.toString(),
          position.longitude.toString(),
        );

        emit(WeatherLoadedState(
          temperature: weatherData.current?.tempC.toString(),
          condition: weatherData.current?.condition?.text,
          iconUrl: weatherData.current?.condition?.icon,
        ));
      }
    } catch (error) {
      emit(
          WeatherErrorState(message: "Error fetching weather details: $error"));
    }
  }
}
