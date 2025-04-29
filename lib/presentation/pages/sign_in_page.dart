import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techware_products/core/utils/app_theme.dart';
import 'package:techware_products/core/utils/secure_storage_support.dart';
import 'package:techware_products/presentation/notifiers/auth_notifier.dart';
import 'package:techware_products/core/utils/app_fade_transition.dart';
import 'package:techware_products/presentation/pages/homepage.dart';
import 'package:techware_products/presentation/pages/setup_pin_page.dart.dart';
import 'package:techware_products/presentation/widgets/common_appbar.dart';
import 'package:techware_products/presentation/widgets/input_text.dart';
import 'package:techware_products/presentation/widgets/primary_button.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  static Route route() {
    return AppFadeTransition(page: const SignInPage());
  }

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      await ref.read(authNotifierProvider.notifier).login(email: _emailController.text.trim(), password: _passwordController.text.trim());

      final user = ref.read(authNotifierProvider).value;
      if (user != null) {
        final pin = await SecureStorageService.getPin();
        if (pin != null) {
          if (!mounted) return;
          Navigator.pushAndRemoveUntil(context, HomePage.route(), (route) => false);
        } else {
          if (!mounted) return;
          Navigator.pushAndRemoveUntil(context, SetupPinPage.route(), (route) => false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      backgroundColor: appColor(context).background,
      appBar: PreferredSize(preferredSize: Size.fromHeight(80), child: CommonAppbar(title: "Sign In", isNeedBackArrow: false)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputText(
                controller: _emailController,
                onChanged: (value) {},
                labelText: 'Email',
                validator: (value) => value == null || value.isEmpty ? 'Enter your email' : null,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              InputText(
                controller: _passwordController,
                obscureText: true,
                onChanged: (value) {},
                labelText: 'Password',
                validator: (value) => value == null || value.isEmpty ? 'Enter your password' : null,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 24),
              PrimaryButton(isLoading: authState.isLoading, buttonColor: appColor(context).buttonColor, buttonText: 'Login', onPressed: _login),
              const SizedBox(height: 12),
              if (authState.hasError) Text(authState.error.toString(), style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
