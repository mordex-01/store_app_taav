// import 'dart:convert';
// import 'dart:typed_data';

class ProductViewModel {
  ProductViewModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.count,
      required this.isActive,
      this.image,
      required this.color,
      required this.tag,
      this.cartMode,
      this.cartCount});
  final String id;
  final String title;
  final String description;
  final String price;
  final String count;
  late bool isActive;
  final String? image;
  final List<dynamic> color;
  final List<dynamic> tag;
  final bool? cartMode;
  final String? cartCount;

  factory ProductViewModel.fromJson(Map<String, dynamic> json) =>
      ProductViewModel(
          id: json['id'],
          title: json['title'],
          description: json['description'],
          price: json['price'],
          count: json['count'],
          isActive: json['isActive'],
          image: json['image'],
          color: json['colors'],
          tag: json['tags'],
          cartMode: json['cartMode'],
          cartCount: json['cartCount']);
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