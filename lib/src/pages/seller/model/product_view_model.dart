// import 'dart:convert';
// import 'dart:typed_data';

class ProductViewModel {
  ProductViewModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.isActive,
    // this.image,
  });

  final String id;
  final String title;
  final String description;
  final String price;
  late bool isActive;
  // final Uint8List? image;

  factory ProductViewModel.fromJson(Map<String, dynamic> json) =>
      ProductViewModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: json['price'],
        isActive: json['isActive'],
        // image: Uint8List.fromList(base64Decode(json['image'])),
      );
}


  // "product": [
  //   {
  //     "id": "0",
  //     "title": "thats my title",
  //     "description": "thats my description",
  //     "price": "600",
  //     "isActive": true
  //   }
  // ]