import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

 @override
 State<SplashScreen> createState() => _SplashScreenState();
 
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: 
      Padding(padding: const EdgeInsets.all(12.0), 
      child: Center(child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Image.asset('assets/images/logo.png',
        ),
        SizedBox(height: 10),
        Text('Welcome to the Shopping App', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.red)),  
      ],),),
      ),
      ),
    );
  }
  }