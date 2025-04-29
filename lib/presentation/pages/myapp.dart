import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techware_products/core/utils/app_theme.dart';
import 'package:techware_products/presentation/pages/splash_screen.dart';

class MyApp extends ConsumerStatefulWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  const MyApp({super.key, this.navigatorKey});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: widget.navigatorKey,
      theme: getAppTheme(context),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}