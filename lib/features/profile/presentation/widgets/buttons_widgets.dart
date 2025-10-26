import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/component/button/p_button.dart';
import '../../../../core/data/constants/app_colors.dart';
import '../../../../core/global/enums/global_enum.dart';

class ButtonsWidgets extends StatelessWidget {
  final bool isEdit;
  final VoidCallback? onSave;
  final VoidCallback? onCancel;

  const ButtonsWidgets({
    super.key,
    required this.isEdit,
    this.onSave,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isEdit)
          PRoundedButton(
            borderRadius: 15,
            onPressed: () {},
            title: "Sign out",
            size: PSize.text14,
            icon: Icons.logout_outlined,
            textColor: AppColors.whiteColor,
          ),
        if (isEdit)
          Column(
            children: [
              PRoundedButton(
                borderRadius: 15,
                onPressed: onSave,
                title: "Save Changes",
                size: PSize.text14,
                textColor: AppColors.whiteColor,
              ),
              SizedBox(height: 2.h),
              PRoundedButton(
                borderRadius: 15,
                onPressed: onCancel,
                title: "Cancel",
                isOutlined: true,
                size: PSize.text14,
                textColor: AppColors.black,
              ),
            ],
          ),
      ],
    );
  }
}
