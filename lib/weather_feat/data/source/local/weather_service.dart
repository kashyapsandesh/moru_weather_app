import 'package:moru_weather_app/weather_feat/data/repositories_impl/get_weather_details_repo_impl.dart';
import 'package:moru_weather_app/weather_feat/data/source/local/weather_storage.dart';

class WeatherService {
  final GetWeatherDetailsRepoImpl weatherRepo = GetWeatherDetailsRepoImpl();
  final WeatherStorage weatherStorage = WeatherStorage();

  Future<bool?> checkWhetherLocationSaved() async {
    final location = await weatherStorage.readLocation();
    return location != null && location.isNotEmpty;
  }

}
