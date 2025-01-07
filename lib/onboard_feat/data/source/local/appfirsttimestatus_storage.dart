import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppFirstTimeStatusStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // Save app first-time status
  Future<void> saveAppFirstTimeStatus(bool isFirstTime) async {
    await storage.write(
        key: 'appFirstTimeStatus', value: isFirstTime.toString());
  }

  // Read app first-time status
  Future<bool> readAppFirstTimeStatus() async {
    String? status = await storage.read(key: 'appFirstTimeStatus');
    return status == null || status == 'true';
  }

  // Clear app first-time status
  Future<void> clearAppFirstTimeStatus() async {
    await storage.delete(key: 'appFirstTimeStatus');
  }
}
