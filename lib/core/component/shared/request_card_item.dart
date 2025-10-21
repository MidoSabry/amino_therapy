
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../data/constants/app_colors.dart';
import '../../global/enums/global_enum.dart';
import '../../global/enums/request_status.dart';
import '../custom_status_card/status_card.dart';
import '../text/p_text.dart';

class CustomRequestCard extends StatelessWidget {
  final String title;
  final RequestStatus? status;
  final Map<String, String> fields;
  final VoidCallback? onTap;
  final bool translateTitle;

  const CustomRequestCard({
    super.key,
    required this.title,
    this.status,
    this.onTap,
    required this.fields,
    this.translateTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    final fieldList = fields.entries.toList();
    final List<Widget> fieldRows = [];

    for (int i = 0; i < fieldList.length; i += 2) {
      // Take two items for the row
      final rowItems = fieldList.skip(i).take(2).toList();

      fieldRows.add(
        Row(
          children: rowItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return Expanded(
              child: Row(
                children: [
                  // Divider only before second column
                  if (index == 1)
                    Container(
                      width: 1,
                      height: 30,
                      color: AppColors.black,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PText(
                          title: item.key.tr(),
                          fontColor: AppColors.black,
                          size: PSize.text14,
                          fontWeight: FontWeight.w500,
                        ),
                        PText(
                          title: item.value,
                          fontColor: AppColors.hintTextColor,
                          size: PSize.text14,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );

      if (i + 2 < fieldList.length) {
        fieldRows.add(SizedBox(height: 1.h));
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.greyColor3, width: 1),
          // boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: PText(
                    title: translateTitle ? title.tr() : title,
                    fontWeight: FontWeight.w500,
                    size: PSize.text16,
                  ),
                ),
                const SizedBox(width: 6),
                status != null
                    ? CustomStatusCard(status: status!)
                    : const SizedBox.shrink(),
              ],
            ),
            SizedBox(height: 2.h),
            ...fieldRows,
          ],
        ),
      ),
    );
  }
}
