import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {

 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Icon(Icons.person, 
                      size: 60),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 50),
                        Text('Santhosh',style:Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black,fontSize: 20)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.edit,size: 17,)),
                      ],
                    ),                 
                    SizedBox(height: 10),
                    Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 50),
                        Text('Phone: ',style:Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black,fontSize: 20)),
                        Text('1234567890',style:Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black,fontSize: 20)),
                      ],
                    ),
                    SizedBox(height: 10),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        Text('Address: ',style:Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black,fontSize: 20)),
                        Text('Kolar',style:Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black,fontSize: 20)),
                      ],
                    ),
                    SizedBox(height: 10),
                      
                  ],
                )
                  ),
                ),
          ]
              ),
            ),
    
        );
     
      }
}