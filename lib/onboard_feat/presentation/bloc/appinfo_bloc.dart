import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moru_weather_app/onboard_feat/data/source/local/appfirsttimestatus_storage.dart';
import 'package:moru_weather_app/onboard_feat/presentation/bloc/appinfo_event.dart';
import 'package:moru_weather_app/onboard_feat/presentation/bloc/appinfo_state.dart';

class AppinfoBloc extends Bloc<AppinfoEvent, AppinfoState> {
  AppinfoBloc() : super(AppinfoInitial()) {
    on<AppinfoCompleteEvent>(_appinfoTimeCompleted);
    on<AppinfoFirstTimeEvent>(_appinfoFirstTime);
  }
  void _appinfoTimeCompleted(
      AppinfoCompleteEvent event, Emitter<AppinfoState> emit) async {
    await Future.delayed(const Duration(seconds: 5), () {
      // After the delay, emit the complete state
      emit(AppinfoCompleteState());
    });
  }

  void _appinfoFirstTime(
      AppinfoFirstTimeEvent event, Emitter<AppinfoState> emit) async {
    await AppFirstTimeStatusStorage().saveAppFirstTimeStatus(false);
    emit(AppinfoCompleteState());
  }
}
