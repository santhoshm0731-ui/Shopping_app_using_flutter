import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 final List<String> filters= const['All','Addidas','Nike','Bata'];

  late String _selectedFilter;

  @override
  void initState(){
    super.initState();
    _selectedFilter=filters[0];
  }

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
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    child: Chip(label: Text(filter),
                    backgroundColor: _selectedFilter == filter ? const Color.fromARGB(255, 205, 217, 75) : Colors.grey,
                    labelStyle: TextStyle(fontSize: 15),
                    ),
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