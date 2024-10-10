import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:product_manage_app/services/storage_service.dart';

class ProductService {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  User? user = FirebaseAuth.instance.currentUser;
  Future<DocumentReference> addProduct(
      String name, String category, double price, String imageUrl) async {
    return await products.add({
      'uid': user!.uid,
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
    await StorageService().deleteImage(imageUrl);
  }
}
