
import 'package:flutter/material.dart';
import '../../data/assets_helper/app_svg_icon.dart';
import '../../global/enums/global_enum.dart';
import '../../global/enums/request_status.dart';
import '../custom_checkboxs/custom_checkboxs_list.dart';
import '../custom_date_picker/custom_date_picker.dart';
import '../image/p_image.dart';
import '../text_field/p_textfield.dart';

class RequestsFilterBottomSheet extends StatelessWidget {
  const RequestsFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width,

          child: PTextField(
            hintText: 'search',
            labelAbove: 'filterResults',
            labelAboveFontSize: PSize.text16,
            labelAboveFontWeight: FontWeight.w500,
            feedback: (value) {},
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const PImage(
                source: AppSvgIcons.search,
                height: 24,
                width: 24,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        CheckboxsListMultiSelect(
          values: RequestStatus.values.map((e) => e.name).toList(),

          onChange: (values) {},
        ),
        const SizedBox(height: 8),
        const CustomDatePicker(title: 'fromDate'),
        const SizedBox(height: 12),
        const CustomDatePicker(title: 'toDate'),
      ],
    );
  }
}
