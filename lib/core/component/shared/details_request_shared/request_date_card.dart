
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../data/constants/app_colors.dart';
import '../../../global/enums/global_enum.dart';
import '../../text/p_text.dart';
import '../title_subtitle_widget.dart';

class RequestDateCard extends StatelessWidget {
  const RequestDateCard({
    super.key,
    this.title,
    required this.date,
    this.isVertical = false,
  });
  final String? title;
  final String date;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat(
      'd MMM yyyy',
      context.locale.languageCode,
    ).format(DateTime.parse(date));
    return isVertical
        ? TitleSubtitleWidget(title: 'requestDate', subTitle: formattedDate)
        : Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            PText(
              title: title?.tr() ?? 'requestDate'.tr(),
              size: PSize.text16,
              fontWeight: FontWeight.w500,
            ),

            const Spacer(),
            PText(
              title: formattedDate,
              size: PSize.text14,
              fontWeight: FontWeight.w400,
              fontColor: AppColors.hintTextColor,
            ),
          ],
        );
  }
}
