import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:product_manage_app/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Manage App',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: SignupScreen(),
    );
  }
}
