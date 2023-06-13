class Products {
  int? id;
  String? title, description;
  Map<String,dynamic> category;
  List image;
  dynamic price;
  Products({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.image,
  });

  factory Products.formJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: json['price'],
      image: json['images'],
    );
  }
}
