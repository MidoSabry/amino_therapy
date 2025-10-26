import 'package:amino_therapy/core/component/text/p_text.dart';
import 'package:amino_therapy/core/data/constants/app_colors.dart';
import 'package:amino_therapy/core/global/enums/global_enum.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/component/text_field/p_textfield.dart';

class ContactInfo extends StatelessWidget {
  final bool isEdit;
  final String email;
  final String phone;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPhoneChanged;

  const ContactInfo({
    super.key,
    required this.isEdit,
    required this.email,
    required this.phone,
    required this.onEmailChanged,
    required this.onPhoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PText(
          title: 'Contact Information',
          fontWeight: FontWeight.bold,
          size: PSize.text18,
        ),
        SizedBox(height: 2.h),
        _buildEditableTile(
          icon: Icons.email_outlined,
          label: 'Email',
          value: email,
          isEdit: isEdit,
          onChanged: onEmailChanged,
        ),
        SizedBox(height: 2.h),
        _buildEditableTile(
          icon: Icons.phone_outlined,
          label: 'Phone',
          value: phone,
          isEdit: isEdit,
          onChanged: onPhoneChanged,
        ),
      ],
    );
  }

  Widget _buildEditableTile({
    required IconData icon,
    required String label,
    required String value,
    required bool isEdit,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFD25E4A)),
        title: PText(
          title: label,
          fontColor: AppColors.grayColor500,
          size: PSize.text14,
        ),
        subtitle: isEdit
            ? PTextField(
                controller: TextEditingController(text: value),
                hintText: value,
                feedback: (value) {},
              )
            : PText(
                title: value,
                fontWeight: FontWeight.bold,
                size: PSize.text14,
              ),
      ),
    );
  }
}
