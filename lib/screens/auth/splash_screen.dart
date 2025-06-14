import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_field/core/app_images.dart';
import 'package:pixel_field/core/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        context.go('/welcome');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bottomNavBarColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background pattern
          Image.asset(AppImages.background, fit: BoxFit.cover),
          // Centered logo/text
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Image.asset(AppImages.splash)],
            ),
          ),
        ],
      ),
    );
  }
}
