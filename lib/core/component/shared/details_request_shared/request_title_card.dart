import 'package:amino_therapy/core/extensions/string_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../global/enums/global_enum.dart';
import '../../../global/enums/request_status.dart';
import '../../custom_status_card/status_card.dart';
import '../../text/p_text.dart';

class RequestTitleCard extends StatelessWidget {
  const RequestTitleCard({
    super.key,
    required this.title,
    required this.status,
    this.additionalInfo,
  });
  final String title;
  final RequestStatus status;
  final String? additionalInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        PText(
          title: title.tr(),
          size: PSize.text18,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(width: 2.w),
        additionalInfo!.isEmptyOrNull
            ? const SizedBox.shrink()
            : PText(
              title: additionalInfo!.tr(),
              size: PSize.text18,
              fontWeight: FontWeight.w500,
            ),
        const Spacer(),

        // const PImage(source: AppSvgIcons.timerIcon),
        // PText(
        //   title: status.name.tr(),
        //   size: PSize.text14,
        //   fontWeight: FontWeight.w500,
        //   fontColor: AppColors.hintTextColor,
        // ),
        CustomStatusCard(status: status),
      ],
    );
  }
}
