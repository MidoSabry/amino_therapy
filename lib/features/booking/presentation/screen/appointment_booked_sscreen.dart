import 'dart:async';

import 'package:amino_therapy/core/component/text/p_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/data/constants/app_colors.dart';
import '../../../../core/global/enums/global_enum.dart';

class AppointmentBookedScreen extends StatefulWidget {
  const AppointmentBookedScreen({super.key});

  @override
  State<AppointmentBookedScreen> createState() =>
      _AppointmentBookedScreenState();
}

class _AppointmentBookedScreenState extends State<AppointmentBookedScreen> {
  @override
  void initState() {
    super.initState();

    // Wait 5 seconds then pop back
    Timer(const Duration(seconds: 5), () {
      if (mounted)
        Navigator.pop(context, true); // return true to indicate success
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreens,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circle with check icon
              CircleAvatar(
                radius: 48,
                backgroundColor: const Color(
                  0xFFF5DAD3,
                ), // soft red/pink circle
                child: Icon(
                  Icons.check,
                  color: AppColors.primaryColor, // red checkmark
                  size: 40,
                ),
              ),
              const SizedBox(height: 32),

              // Title text
              const PText(
                title: "Appointment Booked!",
                size: PSize.text24,
                fontColor: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 12),

              // Subtitle text
              PText(
                title:
                    "Your appointment has been confirmed. Check your email for details.",
                textAlign: TextAlign.center,

                size: PSize.text16,
                fontColor: AppColors.grayColor700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
