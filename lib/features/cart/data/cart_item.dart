class CartItemModel {
  final String productId;
  final String title;
  final String imageUrl;
  final double price;
  final double? discountPrice; 
  final int quantity;
  final int availableStock; 

  CartItemModel({
    required this.productId,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.discountPrice,
    required this.quantity,
    required this.availableStock,
  });

  bool get isOutOfStock => availableStock == 0;

  double get totalItemPrice => (discountPrice ?? price) * quantity;

  CartItemModel copyWith({
    String? productId,
    String? title,
    String? imageUrl,
    double? price,
    double? discountPrice,
    int? quantity,
    int? availableStock,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      quantity: quantity ?? this.quantity,
      availableStock: availableStock ?? this.availableStock,
    );
  }
}
