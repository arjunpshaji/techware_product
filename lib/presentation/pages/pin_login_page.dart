import 'package:flutter/material.dart';
import 'package:techware_products/core/utils/app_fade_transition.dart';
import 'package:techware_products/core/utils/app_theme.dart';
import 'package:techware_products/core/utils/secure_storage_support.dart';
import 'package:techware_products/presentation/pages/homepage.dart';
import 'package:techware_products/presentation/widgets/common_appbar.dart';
import 'package:techware_products/presentation/widgets/input_text.dart';
import 'package:techware_products/presentation/widgets/primary_button.dart';

class PinLoginPage extends StatefulWidget {
  const PinLoginPage({super.key});
  static Route route() {
    return AppFadeTransition(page: const PinLoginPage());
  }

  @override
  State<PinLoginPage> createState() => _PinLoginPageState();
}

class _PinLoginPageState extends State<PinLoginPage> {
  final TextEditingController _pinController = TextEditingController();

  Future<void> _verifyPin() async {
    final savedPin = await SecureStorageService.getPin();

    if (_pinController.text.trim() == savedPin) {
      Navigator.pushAndRemoveUntil(context, HomePage.route(), (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Incorrect PIN')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor(context).background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CommonAppbar(title: "Login with PIN", isNeedBackArrow: true, arrowColor: appColor(context).primary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Enter your 4-digit PIN'),
            const SizedBox(height: 16),
            InputText(
              controller: _pinController,
              onChanged: (value) {},
              labelText: 'Enter PIN',
              obscureText: true,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            PrimaryButton(buttonText: 'Login', onPressed: _verifyPin, buttonColor: appColor(context).buttonColor),
          ],
        ),
      ),
    );
  }
}
