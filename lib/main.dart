import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
void main() {
  runApp(const ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      theme: ThemeData(
       colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
       textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal,color: Colors.black),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal,color: Colors.black),
        
       ),
       inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        hintStyle: TextStyle(color: Colors.grey),
      ),
    ),
    debugShowCheckedModeBanner: false,
    );
  }
}


  