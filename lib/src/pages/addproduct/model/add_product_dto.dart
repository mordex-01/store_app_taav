class AddProductDto {
  AddProductDto(
      {required this.title,
      required this.description,
      required this.price,
      required this.isActive,
      required this.color,
      this.image,
      required this.tag});
  final String title;
  final String description;
  final String price;
  final bool isActive;
  final String? image;
  final List<String> color;
  final List<String> tag;

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "price": price,
        "isActive": isActive,
        "image": image,
        "colors": color,
        "tags": tag,
      };
}
