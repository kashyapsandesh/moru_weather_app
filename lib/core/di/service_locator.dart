import 'package:get_it/get_it.dart';
import 'package:moru_weather_app/weather_feat/data/repositories_impl/get_weather_details_repo_impl.dart';
import 'package:moru_weather_app/weather_feat/presentation/bloc/weather/weather_bloc.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Register your repository
  getIt.registerLazySingleton<GetWeatherDetailsRepoImpl>(() => GetWeatherDetailsRepoImpl());

  // Register your WeatherBloc
  getIt.registerFactory<WeatherBloc>(() => WeatherBloc(getIt<GetWeatherDetailsRepoImpl>()));
}
