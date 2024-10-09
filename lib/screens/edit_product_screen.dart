import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_manage_app/services/product_service.dart';
import 'package:product_manage_app/services/storage_service.dart';

class EditProductScreen extends StatefulWidget {
  final String productId;
  final String initialName;
  final String initialCategory;
  final double initialPrice;
  final String initialImageUrl;

  EditProductScreen({
    required this.productId,
    required this.initialName,
    required this.initialCategory,
    required this.initialPrice,
    required this.initialImageUrl,
  });

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialName;
    _categoryController.text = widget.initialCategory;
    _priceController.text = widget.initialPrice.toString();
  }

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _updateProduct() async {
    String imageUrl = widget.initialImageUrl;
    if (_image != null) {
      imageUrl = await StorageService().uploadImage(_image!);
    }
    await ProductService().updateProduct(widget.productId, {
      'name': _nameController.text,
      'category': _categoryController.text,
      'price': double.parse(_priceController.text),
      'imageUrl': imageUrl,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            _image == null
                ? Image.network(widget.initialImageUrl, height: 150)
                : Image.file(_image!, height: 150),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProduct,
              child: Text('Update Product'),
            ),
          ],
        ),
      ),
    );
  }
}
