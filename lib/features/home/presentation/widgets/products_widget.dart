import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/component/shared/products_shared_widget/product_widget.dart';
import '../../../../core/component/text/p_text.dart';
import '../../../../core/data/assets_helper/app_icon.dart';
import '../../../../core/data/constants/app_colors.dart';
import '../../../../core/data/constants/app_router.dart';
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
            GestureDetector(
              child: PText(
                title: "View All",
                fontColor: AppColors.primaryColor,
                size: PSize.text13,
                fontWeight: FontWeight.w500,
              ),
              onTap: () => context.pushNamed(AppRouter.allProducts),
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

