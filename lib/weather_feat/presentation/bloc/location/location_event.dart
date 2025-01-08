abstract class LocationEvent {}

class LocationPermissionEvent extends LocationEvent {}

class LocationPermissionDeniedEvent extends LocationEvent {}

class LocationPermissionDeniedForeverEvent extends LocationEvent {}

class LocationPermissionGrantedEvent extends LocationEvent {}

class LocationServiceEnabledEvent extends LocationEvent {}

class LocationServiceDisabledEvent extends LocationEvent {}

class LocationServiceRequestEvent extends LocationEvent {}



class FetchLocation extends LocationEvent {}
