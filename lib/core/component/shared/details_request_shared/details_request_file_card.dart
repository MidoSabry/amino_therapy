import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sizer/sizer.dart';

import '../../../data/assets_helper/app_svg_icon.dart';
import '../../../data/constants/app_colors.dart';
import '../../../data/constants/global_obj.dart';
import '../../../global/enums/global_enum.dart';
import '../../../services/file_service_picker/file_service_picker.dart';
import '../../image/p_image.dart';
import '../../text/p_text.dart';

class DetailsRequestFileCard extends StatelessWidget {
  const DetailsRequestFileCard({
    super.key,
    this.pickerType,
    this.date,
    this.name,
  });
  final String? name;
  final PickerType? pickerType;
  final String? date;

  /// Extracts a safe file name from PickerType
  String _getFileName() {
    if (pickerType == null) return "لم يتم اختيار ملف";

    // Case 1: PickerType has a `path` field
    final pathField = (pickerType as dynamic).path;
    if (pathField != null && pathField is String && pathField.isNotEmpty) {
      return p.basename(pathField);
    }

    // Case 2: PickerType has a `file` field (File object)
    final fileField = (pickerType as dynamic).file;
    if (fileField != null && fileField is File) {
      return p.basename(fileField.path);
    }

    // Case 3: PickerType has a `name` field
    final nameField = (pickerType as dynamic).name;
    if (nameField != null && nameField is String && nameField.isNotEmpty) {
      return nameField;
    }

    return "not_choose_file".tr(context: Get.context);
  }

  @override
  Widget build(BuildContext context) {
    final fileName = _getFileName();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Icon in circle
          const PImage(source: AppSvgIcons.shadowFile),
          SizedBox(width: 4.w),
          // Text content
          fileName == "not_choose_file".tr()
              ? Expanded(
                child: PText(
                  title: name ?? fileName,
                  size: PSize.text14,
                  fontWeight: FontWeight.w500,
                  // overflow: TextOverflow.ellipsis,
                ),
              )
              : Column(
                children: [
                  PText(
                    title: fileName,

                    size: PSize.text14,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 4),
                  PText(
                    title: date != null ? "تم انشائه في $date" : "",
                    size: PSize.text12,
                    fontColor: AppColors.hintTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
