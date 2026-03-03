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
       colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
       textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal,color: Colors.black),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal,color: Colors.black),
        
       ),
      ),
       debugShowCheckedModeBanner: false,
    );
  }
}


  