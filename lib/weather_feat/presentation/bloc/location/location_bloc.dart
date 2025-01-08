import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:moru_weather_app/weather_feat/presentation/bloc/location/location_event.dart';
import 'package:moru_weather_app/weather_feat/presentation/bloc/location/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<LocationPermissionEvent>(_locationPermission);
    on<LocationPermissionDeniedEvent>(_locationPermissionDenied);
    on<LocationPermissionDeniedForeverEvent>(_locationPermissionDeniedForever);
    on<LocationPermissionGrantedEvent>(_locationPermissionGranted);
    on<LocationServiceEnabledEvent>(_locationServiceEnabled);
    on<LocationServiceDisabledEvent>(_locationServiceDisabled);
    on<LocationServiceRequestEvent>(_locationServiceRequest);
  }

  void _locationPermission(
      LocationPermissionEvent event, Emitter<LocationState> emit) async {
    try {
      // Using the Geolocator package
      final permission = await Geolocator.checkPermission();
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (permission == LocationPermission.denied) {
        emit(LocationPermissionDeniedState());
      } else if (permission == LocationPermission.deniedForever) {
        emit(LocationPermissionDeniedForeverState());
      } else {
        emit(LocationPermissionGrantedState(
            latitude: position.latitude.toString(),
            longitude: position.longitude.toString()));
      }
    } catch (e) {
      emit(LocationPermissionDeniedState());
    }
  }

  void _locationPermissionDenied(
      LocationPermissionDeniedEvent event, Emitter<LocationState> emit) async {
    emit(LocationPermissionDeniedState());
  }

  void _locationPermissionDeniedForever(
      LocationPermissionDeniedForeverEvent event,
      Emitter<LocationState> emit) async {
    emit(LocationServiceRequestState());
  }

  void _locationPermissionGranted(
      LocationPermissionGrantedEvent event, Emitter<LocationState> emit) async {
    try {} catch (e) {}
  }

  void _locationServiceEnabled(
      LocationServiceEnabledEvent event, Emitter<LocationState> emit) async {
    try {
      final isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();

      if (isLocationServiceEnabled) {
        emit(LocationServiceEnabledState());
      } else {
        emit(LocationServiceDisabledState());
      }
    } catch (e) {
      emit(LocationServiceDisabledState());
    }
  }

  void _locationServiceDisabled(
      LocationServiceDisabledEvent event, Emitter<LocationState> emit) async {
    emit(LocationServiceDisabledState());
  }

  void _locationServiceRequest(
      LocationServiceRequestEvent event, Emitter<LocationState> emit) async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.deniedForever) {
          // Debugging the denied forever case
          print("Location permission denied forever");

          emit(LocationPermissionDeniedForeverState());
          // Open app settings to let the user enable permissions manually

          return;
        } else if (permission == LocationPermission.denied) {
          emit(LocationPermissionDeniedState());

          return;
        }
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        emit(LocationPermissionGrantedState(
            latitude: position.latitude.toString(),
            longitude: position.longitude.toString()));
      } else {
        emit(LocationPermissionDeniedState());
      }
    } catch (e) {
      emit(LocationServiceDisabledState());
    }
  }
}
