import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/global/state/base_state.dart';
import '../../../home/data/model/products.dart';

class ProductsCubit extends Cubit<BaseState> {
  final List<ProductModel> allProducts;

  ProductsCubit(this.allProducts)
      : super(LoadedState<List<ProductModel>>(allProducts));

  void search(String query) {
    final lower = query.toLowerCase();
    if (lower.isEmpty) {
      emit(LoadedState<List<ProductModel>>(allProducts));
    } else {
      final filtered = allProducts
          .where((p) => p.name.toLowerCase().contains(lower))
          .toList();
      emit(LoadedState<List<ProductModel>>(filtered));
    }
  }
}
