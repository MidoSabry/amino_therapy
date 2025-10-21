import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/component/image/p_image.dart';
import '../../../../core/data/assets_helper/app_icon.dart';
import '../../../../core/data/constants/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _handleStartup();
  }

  Future<void> _handleStartup() async {
    // Start both tasks in parallel
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // Normal navigation
    // final bool isLoginKey = SharedPreferenceService().getBool(
    //   SharPrefConstants.isLoginKey,
    // );

    // if (isLoginKey) {
    //   context.goNamed(AppRouter.home);
    // } else {
    //   context.goNamed(AppRouter.login);
    // }
    context.goNamed(AppRouter.home);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: 
        Center(child: PImage(source: AppIcons.logo)),
    
    );
  }
}
