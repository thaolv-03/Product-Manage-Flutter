class Product {
  String id;
  String name;
  String category;
  double price;
  String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
  });

  // Chuyển đổi giữa Product và Map để làm việc với Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  static Product fromMap(String id, Map<String, dynamic> map) {
    return Product(
      id: id,
      name: map['name'],
      category: map['category'],
      price: map['price'],
      imageUrl: map['imageUrl'],
    );
  }
}
