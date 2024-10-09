import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:product_manage_app/screens/add_product_screen.dart';
import 'package:product_manage_app/screens/edit_product_screen.dart';
import 'package:product_manage_app/screens/login_screen.dart';
import 'package:product_manage_app/services/auth_service.dart';
import 'package:product_manage_app/services/product_service.dart';

class ProductListScreen extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthService().signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('uid', isEqualTo: user!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name']),
                subtitle: Text('${data['category']} - ${data['price']} \$'),
                leading: Image.network(data['imageUrl'], width: 90),
                trailing: IconButton(
                    onPressed: () {
                      ProductService().deleteProduct(doc.id, data['imageUrl']);
                    },
                    icon: Icon(Icons.delete)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProductScreen(
                                productId: doc.id,
                                initialName: data['name'],
                                initialCategory: data['category'],
                                initialPrice: data['price'],
                                initialImageUrl: data['imageUrl'],
                              )));
                },
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddProductScreen()));
          }),
    );
  }
}
