class CartDto {
  CartDto({
    required this.customerId,
    required this.productId,
    required this.itemCount,
  });

  final String customerId;
  final String productId;
  final String itemCount;

  Map<String, dynamic> toJson() => {
        'customerId': customerId,
        'productId': productId,
        'itemCount': itemCount
      };
}
