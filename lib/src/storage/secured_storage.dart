import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredStorage {
  late final FlutterSecureStorage _storage;

  SecuredStorage() {
    AndroidOptions getAndroidOptions =
        const AndroidOptions(encryptedSharedPreferences: true);
    _storage = FlutterSecureStorage(aOptions: getAndroidOptions);
  }

  /// Write a value to the storage.
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Read a value from the storage.
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Read all key-value pairs from the storage.
  Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }

  /// Delete a value from the storage.
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Delete all values from the storage.
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
