// import 'dart:typed_data';

class AddProductDto {
  AddProductDto(
      {required this.title,
      required this.description,
      required this.price,
      required this.isActive,
      this.image
      // this.object,
      });
  final String title;
  final String description;
  final String price;
  final bool isActive;
  final String? image;
  // final Uint8List? object;

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "price": price,
        "isActive": isActive,
        "image": image
        // "image": base64Encode(object!)
      };
}
