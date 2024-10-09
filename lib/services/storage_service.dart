import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;
      Reference storageRef = _storage.ref().child('product_images/$fileName');

      UploadTask uploadTask = storageRef.putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Upload error: $e');
      rethrow;
    }
  }

  Future<void> deleteImage(String imageUrl) async {
    try {
      // Chuyển đổi URL thành Reference
      Reference storageRef = _storage.refFromURL(imageUrl);

      // Xóa file khỏi Firebase Storage
      await storageRef.delete();
    } catch (e) {
      print('Delete error: $e');
      throw Exception('File deletion failed');
    }
  }
}
