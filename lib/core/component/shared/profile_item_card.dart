
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/assets_helper/app_svg_icon.dart';
import '../../data/constants/app_colors.dart';
import '../../global/enums/global_enum.dart';
import '../../services/localization/app_localization.dart';
import '../image/p_image.dart';
import '../text/p_text.dart';

class ProfileItemCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback? onTap; // Added onTap parameter

  const ProfileItemCard({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Gives ripple effect
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border.all(color: AppColors.grayColor200),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            PImage(
              source: image,
              height: 24,
              width: 24,
              fit: BoxFit.fill,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 12),
            PText(
              title: title.tr(),
              size: PSize.text16,
              fontWeight: FontWeight.w400,
            ),
            const Spacer(),
            PImage(
              source:
                  AppLocalization.isArabic
                      ? AppSvgIcons.backLeft
                      : AppSvgIcons.backRight,
              height: 24,
              width: 24,
              fit: BoxFit.fill,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
