class AddToCartDto {
  AddToCartDto({
    required this.productId,
    this.storeCount,
    required this.productTitle,
    required this.price,
    required this.count,
  });
  final String productId;
  final String? storeCount;
  final String productTitle;
  final String price;
  final String count;

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'storeCount': storeCount,
        'productTitle': productTitle,
        'price': price,
        'count': count
      };
}
