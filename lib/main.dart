import 'package:flutter/material.dart';
import 'package:shopping/home_page.dart';

void main() {
  runApp(const ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
       colorScheme: .fromSeed(seedColor: Colors.yellow),
      ),
       debugShowCheckedModeBanner: false,
    );
  }
}


  