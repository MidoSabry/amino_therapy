class ProductModel {
  final String name;
  final String price;
  final String image;
  final bool isOutOfStock;

  ProductModel({
    required this.name,
    required this.price,
    required this.image,
    this.isOutOfStock = false,
  });
}
