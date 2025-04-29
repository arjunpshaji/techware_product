import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techware_products/core/utils/app_theme.dart';
import 'package:techware_products/core/utils/secure_storage_support.dart';
import 'package:techware_products/presentation/pages/pin_login_page.dart';
import 'package:techware_products/presentation/pages/setup_pin_page.dart.dart';
import 'package:techware_products/presentation/pages/registration_page.dart';
import 'package:techware_products/presentation/widgets/loader_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<Route<dynamic>> _determineStartPage() async {
    final user = FirebaseAuth.instance.currentUser;
    final pin = await SecureStorageService.getPin();

    if (user != null) {
      if (pin != null) {
        return PinLoginPage.route();
      } else {
        return SetupPinPage.route();
      }
    } else {
      return RegistrationPage.route();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Route<dynamic>>(
      future: _determineStartPage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(backgroundColor: appColor(context).background, body: const LoaderWidget());
        }

        if (snapshot.hasError) {
          return const Scaffold(body: Center(child: Text('Something went wrong')));
        }

        final route = snapshot.data!;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(context, route);
        });

        return const SizedBox.shrink();
      },
    );
  }
}
