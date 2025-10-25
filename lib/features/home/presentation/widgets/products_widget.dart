import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/component/image/p_image.dart';
import '../../../../core/component/text/p_text.dart';
import '../../../../core/data/assets_helper/app_icon.dart';
import '../../../../core/data/constants/app_colors.dart';
import '../../../../core/global/enums/global_enum.dart';
import '../../data/model/products.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProductModel> products = [
      ProductModel(name: "Moisturizer", price: "\$35", image: AppIcons.img1),
      ProductModel(name: "Face Serum", price: "\$45", image: AppIcons.img2),
      ProductModel(
        name: "Lip Balm",
        price: "\$15",
        image: AppIcons.img3,
        isOutOfStock: true,
      ),
      ProductModel(name: "Face Mask", price: "\$28", image: AppIcons.img1),
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PText(
              title: "Featured Products",
              size: PSize.text18,
              fontColor: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
            PText(
              title: "View All",
              fontColor: AppColors.primaryColor,
              size: PSize.text13,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        SizedBox(height: 2.h),
        GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.78,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: products.map((p) => ProductCard(product: p)).toList(),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            offset: Offset(0, 3),
            spreadRadius: 1,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: PImage(
                  source: product.image,
                  height: 15.h,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite_border, size: 22),
                ),
              ),
              if (product.isOutOfStock)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.45),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: const Center(
                      child: PText(
                        title: 'Out of Stock',

                        size: PSize.text18,
                        fontWeight: FontWeight.bold,
                        fontColor: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PText(
                  title: product.name,
                  fontColor: AppColors.black,
                  fontWeight: FontWeight.w600,
                  size: PSize.text16,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PText(
                      title: product.price,
                      fontColor: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      size: PSize.text16,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xffd81b60),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
