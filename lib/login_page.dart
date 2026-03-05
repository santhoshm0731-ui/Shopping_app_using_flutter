
import 'package:flutter/material.dart';
import 'package:shopping/main_navigator.dart';

class LoginPage extends StatelessWidget {
    const LoginPage({super.key});

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
                  Container(child:Column(
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
                          ElevatedButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MainNavigator()));
                          }, child: Text('Login', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color.fromARGB(255, 13, 175, 224)))),
                        ],                  )
                  )
                ],
              ),
            ),
        ),
        ),
      );
    
  }
}