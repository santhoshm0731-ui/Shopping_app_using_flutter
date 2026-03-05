import 'package:flutter/material.dart';
import 'products.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<String> filters = const ['All', 'Adidas', 'Nike', 'Bata', 'Sparx', 'Puma'];
  late String _selectedFilter;
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      final matchesBrand = _selectedFilter == 'All' ||
          product['title'] == _selectedFilter;

      final matchesSearch = searchText.trim().isEmpty ||
          product['title'].toLowerCase().contains(searchText.trim().toLowerCase()) ||
          product['name'].toLowerCase().contains(searchText.trim().toLowerCase());

      return matchesBrand && matchesSearch;
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text("Shoes\nCollection", style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold
                )),
                SizedBox(width: 8),
                Expanded(child: TextField(
                  controller: _searchController,
                  onSubmitted: (value) {
                    setState(() {
                      _searchController.text = value;
                      searchText = _searchController.text;
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                )),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                      child: Chip(
                        label: Text(filter),
                        backgroundColor: _selectedFilter == filter
                            ? const Color.fromARGB(255, 182, 137, 15)
                            : Colors.grey,
                        labelStyle: TextStyle(fontSize: 15),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(product['title'],
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.red),
                            textAlign: TextAlign.left),
                        Image.asset(product['image']),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Model: ${product['name']}",
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.left),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Price: ₹ ${product['price'].toString()}",
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.left),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Size: ${product['size'].toString()}",
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.left),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}