import 'package:amino_therapy/core/component/text/p_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/data/constants/app_colors.dart';
import '../../../../core/global/enums/global_enum.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300, // outline color
          width: 1, // thickness
        ),
      ),
      height: 48,
      alignment: Alignment.center,
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          PText(
            title: "Search services & products…",
            fontColor: AppColors.grayColor400,
            fontWeight: FontWeight.w400,
            size: PSize.text14,
          ),
        ],
      ),
    );
  }
}
