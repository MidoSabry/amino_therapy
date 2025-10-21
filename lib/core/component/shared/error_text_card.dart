import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/constants/app_colors.dart';
import '../text/p_text.dart';

class ErrorTextCard extends StatelessWidget {
  final String? message;
  const ErrorTextCard({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PText(
              title: message ?? 'unexpectedError'.tr(),
              fontColor: AppColors.dangerColor,
            ),
          ],
        ),
      ),
    );
  }
}
