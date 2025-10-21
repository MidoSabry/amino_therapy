
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../data/constants/app_colors.dart';
import '../../global/enums/global_enum.dart';
import '../text/p_text.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: PText(
        title: title.tr(),
        size: PSize.text16,
        fontWeight: FontWeight.w500,
        fontColor: AppColors.primaryColor,
      ),
    );
  }
}
