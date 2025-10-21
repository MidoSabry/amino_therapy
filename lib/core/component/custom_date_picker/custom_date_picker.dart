
import 'package:amino_therapy/core/extensions/string_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../data/assets_helper/app_svg_icon.dart';
import '../../data/constants/app_colors.dart';
import '../../global/enums/global_enum.dart';
import '../../services/localization/app_localization.dart';
import '../image/p_image.dart';
import '../text/p_text.dart';

class CustomDatePicker extends StatefulWidget {
  final String? title;
  final String? hintText;
  final ValueChanged<DateTime?>? onChange;
  final bool isEnabled;
  final DateTime? initialDate;
  final DateTime? lastDate;
  final DateTime? firstDate;
  const CustomDatePicker({
    super.key,
    this.title,
    this.hintText,
    this.onChange,
    this.isEnabled = true,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? pickedDate;
  @override
  void initState() {
    pickedDate = widget.initialDate;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDate != oldWidget.initialDate) {
      pickedDate = widget.initialDate;
      setState(() {}); // rebuild to reflect the change
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title!.isEmptyOrNull
            ? const SizedBox.shrink()
            : PText(
              title: widget.title!.tr(),
              size: PSize.text16,
              fontWeight: FontWeight.w400,
            ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap:
              !widget.isEnabled
                  ? null
                  : () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final tempPickedDate = await showDatePicker(
                      context: context,
                      initialDate: pickedDate,
                      firstDate:
                          widget.firstDate ??
                          DateTime.now().subtract(const Duration(days: 365)),
                      lastDate: widget.lastDate ?? DateTime.now(),
                      initialEntryMode:
                          DatePickerEntryMode
                              .calendarOnly, // 👈 disables typing
                    );
                    if (tempPickedDate != null) {
                      pickedDate = tempPickedDate;
                      if (widget.onChange != null) {
                        widget.onChange!(pickedDate);
                      }
                      setState(() {});
                    }
                  },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.grayColor200),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PText(
                  title:
                      pickedDate == null
                          ? (widget.hintText != null &&
                                  widget.hintText!.isNotEmpty
                              ? widget.hintText!.tr()
                              : 'dateFormatText'.tr())
                          : DateFormat(
                            AppLocalization.isArabic
                                ? 'yyyy/MM/dd'
                                : 'dd/MM/yyyy',
                            context.locale.languageCode,
                          ).format(pickedDate!),
                  size: PSize.text16,
                  fontWeight: FontWeight.w400,
                  fontColor:
                      pickedDate == null
                          ? AppColors.greyColor
                          : widget.isEnabled
                          ? null
                          : AppColors.greyColor,
                ),
                const PImage(
                  source: AppSvgIcons.calendar,
                  height: 24,
                  width: 24,
                  color: AppColors.black,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
