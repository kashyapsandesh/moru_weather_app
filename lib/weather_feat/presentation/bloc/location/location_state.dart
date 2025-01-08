abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationPermissionState extends LocationState {}

class LocationPermissionDeniedState extends LocationState {}

class LocationPermissionDeniedForeverState extends LocationState {}

class LocationPermissionGrantedState extends LocationState {
  final String latitude;
  final String longitude;

  LocationPermissionGrantedState(
      {required this.latitude, required this.longitude});
}

class LocationServiceEnabledState extends LocationState {}

class LocationServiceDisabledState extends LocationState {}

class LocationServiceRequestState extends LocationState {}

class LocationLoaded extends LocationState {}

class LocationCompleteState extends LocationState {}
