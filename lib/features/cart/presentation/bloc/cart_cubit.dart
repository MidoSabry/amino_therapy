import 'package:amino_therapy/core/data/assets_helper/app_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/global/state/base_state.dart';
import '../../data/cart_item.dart';

class CartCubit extends Cubit<BaseState> {
  CartCubit() : super(const LoadedState<List<CartItemModel>>([]));

  List<CartItemModel> get items => (state is LoadedState<List<CartItemModel>>)
      ? (state as LoadedState<List<CartItemModel>>).data ?? []
      : [];

  double get totalPrice =>
      items.fold(0, (total, item) => total + item.totalItemPrice);

  void addProducts(List<CartItemModel> products) {
    final updatedItems = List<CartItemModel>.from(items);

    for (final product in products) {
      final index = updatedItems.indexWhere(
        (i) => i.productId == product.productId,
      );

      if (index != -1) {
        final existingItem = updatedItems[index];
        updatedItems[index] = existingItem.copyWith(
          quantity: existingItem.quantity + product.quantity,
        );
      } else {
        updatedItems.add(product);
      }
    }

    emit(LoadedState<List<CartItemModel>>(updatedItems));
  }

  void addDummyProducts() {
    addProducts([
      CartItemModel(
        productId: "123",
        title: "Protein Bar",
        imageUrl: AppIcons.img1,
        price: 50,
        discountPrice: 40,
        quantity: 1,
        availableStock: 10,
      ),
      CartItemModel(
        productId: "456",
        title: "Whey Protein",
        imageUrl: AppIcons.img2,
        price: 300,
        discountPrice: 250,
        quantity: 1,
        availableStock: 7,
      ),
    ]);
  }

  void removeItem(String productId) {
    final updatedItems = items
        .where((item) => item.productId != productId)
        .toList();
    emit(LoadedState<List<CartItemModel>>(updatedItems));
  }

  void increaseQuantity(String productId) {
    final updatedItems = items.map((item) {
      if (item.productId == productId) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();

    emit(LoadedState<List<CartItemModel>>(updatedItems));
  }

  void decreaseQuantity(String productId) {
    final updatedItems = <CartItemModel>[];

    for (final item in items) {
      if (item.productId == productId) {
        if (item.quantity > 1) {
          // قلل الكمية
          updatedItems.add(item.copyWith(quantity: item.quantity - 1));
        }
        // else --> لا تضيفه => يعني يتم حذفه
      } else {
        updatedItems.add(item);
      }
    }

    emit(LoadedState<List<CartItemModel>>(updatedItems));
  }
}
