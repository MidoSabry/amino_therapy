import 'package:amino_therapy/core/component/button/p_button.dart';
import 'package:amino_therapy/core/component/text/p_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/data/constants/app_colors.dart';
import '../../../../core/global/enums/global_enum.dart';
import '../../data/service_model.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PText(
              title: service.name,
              size: PSize.text14,
              fontWeight: FontWeight.bold,
            ),
            PText(
              title: service.description,
              fontColor: AppColors.black,
              size: PSize.text14,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: AppColors.primaryColor, size: 18),
                const SizedBox(width: 4),
                PText(
                  title: "${service.rating} (${service.reviewsCount} reviews)",
                  size: PSize.text14,
                  fontColor: AppColors.black,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PText(
                  title: "\$${service.price}",
                  size: PSize.text16,
                  fontWeight: FontWeight.bold,
                  fontColor: AppColors.primaryColor,
                ),
                PText(title: service.duration, size: PSize.text14),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.redAccent,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //   ),
                //   onPressed: () {},
                //   child: const Text(
                //     "Book",
                //     style: TextStyle(color: Colors.white),
                //   ),
                // ),
                SizedBox(
                  width: 25.w,
                  child: PRoundedButton(
                    borderRadius: 15,
                    onPressed: () {},
                    title: "Book",
                    size: PSize.text14,
                    textColor: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
