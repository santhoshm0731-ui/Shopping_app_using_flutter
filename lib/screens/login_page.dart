
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/main_navigator.dart';
import 'package:shopping/screens/signup-page.dart';

class LoginPage extends StatelessWidget {
    const LoginPage({super.key});

     Future<void> saveLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', 'd');
    await prefs.setString('phone', '1234567890');
    await prefs.setString('address', 'Kolar');
    await prefs.setBool('isLoggedIn', true);
    }

  // Future<void> checkLoginData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final name = prefs.getString('name');
  //   final phone = prefs.getString('phone');
  //   final address = prefs.getString('address');
  //   if (name == null || phone == null || address == null) {
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  //   }
  //   else {
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainNavigator()));
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                        children: [
                          Text('Enter your Details', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.red,fontSize: 30)),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Mobile Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children:[
                              Expanded(child: ElevatedButton(onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainNavigator()));
                            }, 
                            child: Text('Login', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color.fromARGB(255, 13, 175, 224))
                            ),
                            ),
                        ),
                            ]
                          ),
                          SizedBox(height: 8),
                          TextButton(onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignupPage()),
                          );
                          }
                          ,
                           child: Text('Dont have an account? Signup', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.deepOrangeAccent,fontSize: 16))
                           ),
                        ],   
               )
                  
                ],
              ),
            ),
        ),
        ),
      );
    
  }
}