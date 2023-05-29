/*
This is a 'dataabase' that stores the api keys using
flutter_secure_storage.

Since api keys are sensitive - this requires more attention 
to secure storage. 
*/

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class APIKeyStorageHelper {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> saveGPTAPIKey(String gptKey) async {
    await _secureStorage.write(key: 'gptkey', value: gptKey);
  }

  Future<void> saveELAPIKey(String elevenLabsKey) async {
    await _secureStorage.write(key: 'elevenlabskey', value: elevenLabsKey);
  }

  Future<String?> getGPTAPIKey() async {
    return await _secureStorage.read(key: 'gptkey');
  }

  Future<String?> getELAPIKey() async {
    return await _secureStorage.read(key: 'elevenlabskey');
  }

  void deleteGPTAPIKey() async {
    await _secureStorage.delete(key: 'gptkey');
  }

  void deleteELAPIKey() async {
    await _secureStorage.delete(key: 'elevenlabskey');
  }
}
