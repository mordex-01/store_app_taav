class ProductDto {
  ProductDto(
      {required this.isActive, this.count, this.cartCount, this.cartMode});
  final bool isActive;
  final String? count;
  final String? cartCount;
  final bool? cartMode;
  Map<String, dynamic> toJson() => {
        "isActive": isActive,
        "count": count,
        "cartCount": cartCount,
        "cartMode": cartMode
      };
}
