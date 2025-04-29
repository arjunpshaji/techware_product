import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techware_products/core/utils/app_theme.dart';
import 'package:techware_products/presentation/notifiers/auth_notifier.dart';
import 'package:techware_products/core/utils/app_fade_transition.dart';
import 'package:techware_products/presentation/pages/setup_pin_page.dart.dart';
import 'package:techware_products/presentation/pages/sign_in_page.dart';
import 'package:techware_products/presentation/widgets/common_appbar.dart';
import 'package:techware_products/presentation/widgets/input_text.dart';
import 'package:techware_products/presentation/widgets/primary_button.dart';

class RegistrationPage extends ConsumerWidget {
  const RegistrationPage({super.key});

  static Route route() {
    return AppFadeTransition(page: const RegistrationPage());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null) {
            Navigator.pushReplacement(context, SetupPinPage.route());
          }
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: appColor(context).background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CommonAppbar(title: "Register", isNeedBackArrow: true, arrowColor: appColor(context).primary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputText(
              controller: emailController,
              onChanged: (value) {},
              labelText: 'Enter Email',
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            InputText(
              controller: passwordController,
              onChanged: (value) {},
              labelText: 'Enter Password',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              isLoading: authState.isLoading,
              buttonColor: appColor(context).buttonColor,
              buttonText: 'Register',
              onPressed: () {
                ref.read(authNotifierProvider.notifier).register(email: emailController.text.trim(), password: passwordController.text.trim());
              },
            ),
            const SizedBox(height: 16),
            TextButton(onPressed: () => Navigator.pushReplacement(context, SignInPage.route()), child: const Text('Already have an account? Login')),
          ],
        ),
      ),
    );
  }
}
