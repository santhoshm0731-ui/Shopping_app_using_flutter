import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});
 final List<String> filters= const['All','Addidas','Nike','Bata'];

    @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(child: Padding(
      padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text("Shoes\nCollection",style: TextStyle(
                  fontSize: 30,fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(width: 8),
               Expanded(child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search,
                  color: Colors.grey), 
                  hintText:"Search",
                    hintStyle: TextStyle(color: Colors.grey,
                    ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                  borderSide:BorderSide(color: Colors.black)
                  ),
                  )
                ),
               ),
                ],
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.builder( 
              scrollDirection:Axis.horizontal,  
              itemCount: filters.length,
              itemBuilder: (context, index){
                final filter=filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Chip(label: Text(filter),
                  labelStyle: TextStyle(fontSize: 15),
                  ),
                );
              },
              ),
            )
          ],
        ),
      )),
    );  
  }
}