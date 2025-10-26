import 'package:amino_therapy/core/component/image/p_image.dart';
import 'package:amino_therapy/core/component/text/p_text.dart';
import 'package:amino_therapy/core/global/enums/global_enum.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/data/constants/app_colors.dart';
import '../../data/cart_item.dart';

class CartItemTile extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundScreens,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: PImage(
              source: item.imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          /// Title + Price + Out of stock
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PText(
                  title: item.title,
                  size: PSize.text16,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 4),
                PText(
                  // title: "${item.discountPrice ?? item.price} EGP",
                  title:
                      "${(item.discountPrice ?? item.price) * item.quantity} EGP",
                  size: PSize.text14,
                  fontWeight: FontWeight.w700,
                  fontColor: AppColors.black,
                ),
                if (item.isOutOfStock)
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: PText(
                      title: "Out of stock",
                      size: PSize.text12,
                      fontWeight: FontWeight.w600,
                      fontColor: AppColors.primaryColor,
                    ),
                  ),
              ],
            ),
          ),

          /// Quantity controls + delete
          Container(
            padding: EdgeInsets.only(top: 2.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                GestureDetector(
                  onTap: onDecrease,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Icon(Icons.remove, size: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "${item.quantity}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: onIncrease,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Icon(Icons.add, size: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
