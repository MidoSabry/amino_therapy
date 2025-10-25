import 'package:amino_therapy/core/component/button/p_button.dart';
import 'package:amino_therapy/core/component/text/p_text.dart';
import 'package:amino_therapy/core/global/enums/global_enum.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/data/constants/app_colors.dart';

class OfferCardWidget extends StatelessWidget {
  const OfferCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.2),
          width: 1.5, // border thickness
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_offer_outlined, color: AppColors.primaryColor),
              SizedBox(width: 2.w),
              PText(
                title: "Special Offer",
                size: PSize.text16,
                fontColor: AppColors.black,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          SizedBox(height: 1.h),
          PText(
            title: "Get 20% off on your next appointment when you book today!",
            size: PSize.text14,
            fontColor: AppColors.grayColor600,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: 2.h),
          SizedBox(
            width: 25.w,
            child: PRoundedButton(
              borderRadius: 15,
              onPressed: () {},
              title: "Claim Offer",
              size: PSize.text14,
              textColor: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
