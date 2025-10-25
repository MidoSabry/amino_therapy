import 'package:amino_therapy/core/component/text/p_text.dart';
import 'package:amino_therapy/core/data/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/global/enums/global_enum.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(0, 6),
            color: Colors.grey.withOpacity(0.3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PText(
            textAlign: TextAlign.end,
            title: "Your Loyalty Points",
            size: PSize.text13,
            fontColor: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PText(
                textAlign: TextAlign.end,
                title: "2450",
                size: PSize.text28,
                fontColor: Colors.white,
                fontWeight: FontWeight.w900,
              ),
              Icon(
                Icons.star_border_purple500_rounded,
                color: Colors.white,
                size: 25.sp,
              ),
            ],
          ),
          SizedBox(height: 1.h),
          PText(
            textAlign: TextAlign.end,
            title: "Redeem points at checkout or scan barcode",
            size: PSize.text13,
            fontColor: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
