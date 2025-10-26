import 'package:amino_therapy/core/component/text/p_text.dart';
import 'package:amino_therapy/core/data/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/global/enums/global_enum.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_basket_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          PText(
            title: "Your cart is empty",
            fontColor: AppColors.black,
            fontWeight: FontWeight.w600,
            size: PSize.text16,
          ),
          const SizedBox(height: 8),
          PText(
            title: "Start adding items to make a purchase",
            fontColor: AppColors.grayColor600,
            fontWeight: FontWeight.w400,
            size: PSize.text12,
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              // TODO: navigate to products page
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Browse Products",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
