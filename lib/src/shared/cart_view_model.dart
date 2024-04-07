class CartViewModel {
  CartViewModel({
    required this.id,
    required this.productId,
    this.storeCount,
    required this.productTitle,
    required this.count,
    required this.price,
  });
  final String id;
  final String productId;
  final String? storeCount;
  final String productTitle;
  final String count;
  final String price;

  factory CartViewModel.fromJson(Map<String, dynamic> json) => CartViewModel(
        id: json['id'],
        productId: json['productId'],
        storeCount: json['storeCount'],
        productTitle: json['productTitle'],
        count: json['count'],
        price: json['price'],
      );
}
