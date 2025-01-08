import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WeatherStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
//save location
  Future<void> saveLocation(String location) async {
    await storage.write(key: 'location', value: location);
  }

//read location
  Future<String?> readLocation() async {
    return await storage.read(key: 'location');
  }
//clear location

  Future<void> clearLocation() async {
    await storage.delete(key: 'location');
  }
}
