import 'package:firebase_auth/firebase_auth.dart';
import 'package:techware_products/core/utils/secure_storage_support.dart';

Future<String> determineStartPage() async {
    final user = FirebaseAuth.instance.currentUser;
    final pin = await SecureStorageService.getPin();

    if (user != null) {
      if (pin != null) {
        return 'pin-login';
      } else {
        return 'setup-pin';
      }
    } else {
      return 'register';
    }
  }