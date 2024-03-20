class ProductViewModel {
  ProductViewModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.isActive,
  });

  final String id;
  final String title;
  final String description;
  final String price;
  final bool isActive;

  factory ProductViewModel.fromJson(Map<String, dynamic> json) =>
      ProductViewModel(
          id: json['id'],
          title: json['title'],
          description: json['description'],
          price: json['price'],
          isActive: json['isActive']);
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