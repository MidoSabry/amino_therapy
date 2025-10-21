import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/constants/app_colors.dart';
import '../../global/enums/global_enum.dart';
import '../text/p_text.dart';

class TitleSubtitleWidget extends StatelessWidget {
  const TitleSubtitleWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.isLoading = false,
    this.translateSubtitle = false,
  });

  final String title;
  final String subTitle;
  final bool isLoading;
  final bool translateSubtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title always text
        PText(
          title: title.tr(),
          size: PSize.text14,
          fontWeight: FontWeight.w500,
        ),
        isLoading
            ? Skeletonizer(
              enabled: true,
              containersColor: AppColors.greyColor3,
              child: Container(
                margin: const EdgeInsets.only(top: 8, bottom: 4),
                width: double.infinity,
                height: 22,
                color: AppColors.greyColor3,
              ),
            )
            : PText(
              title: translateSubtitle ? subTitle.tr() : subTitle,
              size: PSize.text14,
              fontColor: AppColors.hintTextColor,
              fontWeight: FontWeight.w400,
            ),
      ],
    );
  }
}
