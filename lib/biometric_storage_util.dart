import 'package:biometric_storage/biometric_storage.dart';

class BiometricStorageUtil {
  static Future<void> write(String key, String value) async {
    final canAuth = await BiometricStorage().canAuthenticate();
    if (canAuth == CanAuthenticateResponse.unsupported) {
      throw Exception('Unsupported platform');
    }
    final storage = await BiometricStorage().getStorage(key,
        options: StorageFileInitOptions(authenticationRequired: true));
    await storage.write(value);
    return;
  }

  static Future<String?> read(String key) async {
    final canAuth = await BiometricStorage().canAuthenticate();
    if (canAuth == CanAuthenticateResponse.unsupported) {
      throw Exception('Unsupported platform');
    }
    final storage = await BiometricStorage().getStorage(key,
        options: StorageFileInitOptions(authenticationRequired: false));
    final response = await storage.read();
    return response;
  }

  static Future<void> delete(String key) async {
    // final canAuth = await BiometricStorage().canAuthenticate();
    // if (canAuth == CanAuthenticateResponse.unsupported) {
    //   throw Exception('Unsupported platform');
    // }
    final storage = await BiometricStorage().getStorage(key,
        options: StorageFileInitOptions(authenticationRequired: false));
    await storage.delete();
    return;
  }
}
