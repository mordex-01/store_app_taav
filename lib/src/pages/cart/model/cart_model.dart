class CartModel {
  CartModel({
    this.id,
    required this.customerId,
    required this.productId,
    required this.itemCount,
  });
  final String? id;
  final String customerId;
  final String productId;
  final String itemCount;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json['id'],
        customerId: json['customerId'],
        productId: json['productId'],
        itemCount: json['itemCount'],
      );
}
