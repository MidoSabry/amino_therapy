import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/component/button/p_button.dart';
import '../../../../core/component/text/p_text.dart';
import '../../../../core/data/constants/app_colors.dart';
import '../../../../core/global/enums/global_enum.dart';

class BookAppointmentWidget extends StatelessWidget {
  const BookAppointmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.yeallowColor,
        borderRadius: BorderRadius.circular(20),
        // border: Border.all(
        //   color: AppColors.primaryColor.withOpacity(0.2),
        //   width: 1.5, // border thickness
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PText(
            title: "Book Your Next Appointment",
            size: PSize.text16,
            fontColor: AppColors.black,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 1.h),
          PText(
            title: "Get 10% off your first booking",
            size: PSize.text14,
            fontColor: AppColors.grayColor600,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: 2.h),
          PRoundedButton(
            borderRadius: 15,
            onPressed: () {},
            title: "Book Now",
            size: PSize.text14,
            textColor: AppColors.whiteColor,
          ),
        ],
      ),
    );
  }
}
