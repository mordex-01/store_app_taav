class AddProductDto {
  AddProductDto({
    this.sellerId,
    required this.title,
    required this.description,
    required this.price,
    required this.count,
    required this.isActive,
    required this.color,
    this.image,
    required this.tag,
  });
  final String? sellerId;
  final String title;
  final String description;
  final String price;
  final String count;
  final bool isActive;
  final String? image;
  final List<String> color;
  final List<String> tag;

  Map<String, dynamic> toJson() => {
        "sellerId": sellerId,
        "title": title,
        "description": description,
        "price": price,
        "count": count,
        "isActive": isActive,
        "image": image,
        "colors": color,
        "tags": tag,
      };
}
