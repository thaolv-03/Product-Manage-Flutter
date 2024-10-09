import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  Future<void> addProduct(
      String name, String category, double price, String imageUrl) async {
    await products.add({
      'name': name,
      'category': category,
      'price': price,
      'imageUrl': imageUrl,
    });
  }

  Future<void> updateProduct(
      String productId, Map<String, dynamic> updateData) async {
    await products.doc(productId).update(updateData);
  }

  Future<void> deleteProduct(String productId, String imageUrl) async {
    await products.doc(productId).delete();
  }
}
