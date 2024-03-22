class AddProductDto {
  AddProductDto({
    required this.title,
    required this.description,
    required this.price,
    required this.isActive,
  });
  final String title;
  final String description;
  final String price;
  final bool isActive;
  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "price": price,
        "isActive": isActive
      };
}
