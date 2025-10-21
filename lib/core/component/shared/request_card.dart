
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/constants/app_colors.dart';
import '../../global/enums/global_enum.dart';
import '../image/p_image.dart';
import '../text/p_text.dart';

class RequestCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;
  const RequestCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.grayColor100),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PImage(
              source: image,
              height: 18,
              width: 18,
              fit: BoxFit.fill,
              color: AppColors.primaryColor,
            ),

            Expanded(
              child: PText(
                title: title.tr(),
                size: PSize.text14,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
