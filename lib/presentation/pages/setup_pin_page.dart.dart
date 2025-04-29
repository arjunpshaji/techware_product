import 'package:flutter/material.dart';
import 'package:techware_products/core/utils/app_fade_transition.dart';
import 'package:techware_products/core/utils/app_theme.dart';
import 'package:techware_products/core/utils/secure_storage_support.dart';
import 'package:techware_products/presentation/pages/homepage.dart';
import 'package:techware_products/presentation/widgets/common_appbar.dart';
import 'package:techware_products/presentation/widgets/input_text.dart';
import 'package:techware_products/presentation/widgets/primary_button.dart';

class SetupPinPage extends StatefulWidget {
  const SetupPinPage({super.key});

  static Route route() {
    return AppFadeTransition(page: const SetupPinPage());
  }

  @override
  State<SetupPinPage> createState() => _SetupPinPageState();
}

class _SetupPinPageState extends State<SetupPinPage> {
  final TextEditingController _pinController = TextEditingController();

  Future<void> _savePin() async {
    final pin = _pinController.text.trim();
    if (pin.length != 4 || !RegExp(r'^\d{4}$').hasMatch(pin)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid 4-digit PIN')));
      return;
    }

    await SecureStorageService.savePin(pin);

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(context, HomePage.route(), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor(context).background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CommonAppbar(title: "Set PIN", isNeedBackArrow: true, arrowColor: appColor(context).primary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Create a PIN for quick login'),
            const SizedBox(height: 16),
            InputText(
              controller: _pinController,
              keyboardType: TextInputType.number,
              obscureText: true,
              onChanged: (value) {},
              labelText: 'Enter PIN',
            ),
            const SizedBox(height: 20),
            PrimaryButton(buttonText: 'Save PIN', onPressed: _savePin, buttonColor: appColor(context).buttonColor),
          ],
        ),
      ),
    );
  }
}
