import 'package:amino_therapy/core/component/text/p_text.dart';
import 'package:amino_therapy/core/component/text_field/p_textfield.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/data/constants/app_colors.dart';
import '../../../../core/global/enums/global_enum.dart';

class ProfileHeader extends StatelessWidget {
  final bool isEdit;
  final String name;
  final ValueChanged<String> onChanged;

  const ProfileHeader({
    super.key,
    required this.isEdit,
    required this.name,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.primaryColor,
            child: Icon(
              Icons.person_outline,
              color: AppColors.whiteColor,
              size: 40,
            ),
          ),
          SizedBox(height: 2.h),
          isEdit
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: PTextField(
                    controller: TextEditingController(text: name),
                    hintText: name,
                    feedback: (value) {},
                    isCenter: true,
                    size: PSize.text20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : PText(
                  title: name,
                  size: PSize.text20,
                  fontColor: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
          PText(
            title: 'Member since Oct 2023',
            size: PSize.text12,
            fontColor: AppColors.grayColor600,
          ),
        ],
      ),
    );
  }
}
