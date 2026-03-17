import 'package:flutter/material.dart';

import '../products.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<String> filters = const [
    'All',
    'Adidas',
    'Nike',
    'Bata',
    'Sparx',
    'Puma',
  ];

  final TextEditingController _searchController = TextEditingController();
  late String _selectedFilter;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _selectedFilter = filters.first;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredProducts {
    final query = _searchText.trim().toLowerCase();

    return products.where((product) {
      final brand = (product['title'] as String).toLowerCase();
      final name = (product['name'] as String).toLowerCase();
      final matchesBrand =
          _selectedFilter == 'All' || product['title'] == _selectedFilter;
      final matchesSearch =
          query.isEmpty || brand.contains(query) || name.contains(query);

      return matchesBrand && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _filteredProducts;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Shoes\nCollection',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintText: 'Search',
                        hintStyle: const TextStyle(color: Colors.grey),
                        suffixIcon: _searchText.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchText = '';
                                  });
                                },
                                icon: const Icon(Icons.close),
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 56,
                child: _buildFilters(),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _buildProducts(filteredProducts),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: filters.length,
      separatorBuilder: (_, __) => const SizedBox(width: 10),
      itemBuilder: (context, index) {
        final filter = filters[index];

        return ChoiceChip(
          label: Text(filter),
          selected: _selectedFilter == filter,
          onSelected: (_) {
            setState(() {
              _selectedFilter = filter;
            });
          },
          selectedColor: const Color.fromARGB(255, 182, 137, 15),
          backgroundColor: Colors.white,
          labelStyle: TextStyle(
            fontSize: 15,
            color: _selectedFilter == filter ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        );
      },
    );
  }

  Widget _buildProducts(List<Map<String, dynamic>> filteredProducts) {
    if (filteredProducts.isEmpty) {
      return Center(
        child: Text(
          'No products found',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: Colors.grey.shade600),
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        final sizes = (product['size'] as List).join(', ');

        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product['title'] as String,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Image.asset(
                  product['image'] as String,
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Model: ${product['name']}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Price: ₹ ${product['price']}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Available Sizes: $sizes',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}