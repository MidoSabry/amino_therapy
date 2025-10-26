import 'package:amino_therapy/core/component/button/p_button.dart';
import 'package:amino_therapy/core/component/text/p_text.dart';
import 'package:amino_therapy/core/global/enums/global_enum.dart';
import 'package:amino_therapy/core/global/state/base_state.dart';
import 'package:amino_therapy/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/component/appbar/custom_appbar.dart';
import '../../../../core/data/constants/app_colors.dart';
import '../bloc/cart_cubit.dart';
import '../widgets/empty_cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundScreens,
        appBar: CustomAppBar(
          title: 'Cart',
          isCenterTitle: true,
          showBackButton: false,
        ),
        body: BlocProvider(
          create: (_) => CartCubit()..addDummyProducts(),
          child: BlocBuilder<CartCubit, BaseState>(
            builder: (context, state) {
              final cubit = context.read<CartCubit>();

              return BlocBuilder<CartCubit, BaseState>(
                builder: (context, state) {
                  if (state is LoadedState && cubit.items.isEmpty) {
                    return const EmptyCartWidget();
                  }

                  final totalPrice = cubit.totalPrice;
                  final cartItems = cubit.items;
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: cartItems.length,
                          itemBuilder: (_, index) {
                            final item = cartItems[index];
                            return CartItemTile(
                              item: item,
                              onIncrease: () => context
                                  .read<CartCubit>()
                                  .increaseQuantity(item.productId),
                              onDecrease: () => context
                                  .read<CartCubit>()
                                  .decreaseQuantity(item.productId),
                              onRemove: () => context
                                  .read<CartCubit>()
                                  .removeItem(item.productId),
                            );
                          },
                        ),
                      ),
                      _buildTotalSection(totalPrice),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTotalSection(double totalPrice) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, -2),
            color: Colors.black12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PText(
            title: "Total: $totalPrice EGP",
            size: PSize.text16,
            fontColor: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
          PButton<CartCubit, BaseState>(
            hasCubit: true,
            isFirstButton: true,
            isButtonAlwaysExist: false,
            onPressed: () {},
            title: "checkout",
            size: PSize.text16,
            borderRadius: 12,
          ),
        ],
      ),
    );
  }
}
