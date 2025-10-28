import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/component/appbar/custom_appbar.dart';
import '../../../../core/component/shared/products_shared_widget/product_widget.dart';
import '../../../../core/data/assets_helper/app_icon.dart';
import '../../../../core/data/constants/app_colors.dart';
import '../../../../core/global/state/base_state.dart';
import '../../../home/data/model/products.dart';
import '../bloc/allproducts_cubit.dart';
import '../widgets/search_products_widget.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

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
      ProductModel(name: "Moisturizer", price: "\$35", image: AppIcons.img1),
      ProductModel(name: "Face Serum", price: "\$45", image: AppIcons.img2),
      ProductModel(
        name: "Lip Balm",
        price: "\$15",
        image: AppIcons.img3,
        isOutOfStock: true,
      ),
      ProductModel(name: "Face Mask", price: "\$28", image: AppIcons.img1),
      ProductModel(name: "Moisturizer", price: "\$35", image: AppIcons.img1),
      ProductModel(name: "Face Serum", price: "\$45", image: AppIcons.img2),
      ProductModel(
        name: "Lip Balm",
        price: "\$15",
        image: AppIcons.img3,
        isOutOfStock: true,
      ),
      ProductModel(name: "Face Mask", price: "\$28", image: AppIcons.img1),
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
    return BlocProvider(
      create: (_) => ProductsCubit(products),
      child: Scaffold(
        backgroundColor: AppColors.backgroundScreens,
        appBar: CustomAppBar(
          title: 'Our Products',
          isCenterTitle: false,
          showBackButton: true,
          hasSubtitle: true,
          subtitle: 'Shop our premium beauty products',
        ),
        body: BlocBuilder<ProductsCubit, BaseState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16,
              ),
              child: Column(
                children: [
                  ProductsSearchWidget(
                    onChanged: context.read<ProductsCubit>().search,
                  ),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: BlocBuilder<ProductsCubit, BaseState>(
                      builder: (context, state) {
                        if (state is LoadedState<List<ProductModel>>) {
                          final filtered = state.data!;
                          return GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: 0.77,
                            padding: const EdgeInsets.all(8),
                            children: filtered
                                .map((p) => ProductCard(product: p))
                                .toList(),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
