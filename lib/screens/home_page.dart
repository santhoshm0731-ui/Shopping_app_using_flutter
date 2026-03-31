import 'package:flutter/material.dart';

import 'cart_page.dart';
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
  int _cartItemCount = 0;
  List<Map<String, dynamic>> cartItems = [];

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
      bottomNavigationBar: _cartItemCount > 0
          ? SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Items added to cart',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$_cartItemCount item${_cartItemCount == 1 ? '' : 's'}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CartContent(cartItems: cartItems),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: theme.colorScheme.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('View cart'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Shoes Collection',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CartContent(cartItems: cartItems),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
                    tooltip: 'Cart',
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    icon: const Icon(Icons.person_outline),
                    tooltip: 'Profile',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
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
                  hintText: 'Search by brand or model',
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
          child: GestureDetector(
            
          onTap: () {
            final name = product['name'] as String;
            final price = product['price'] as int;
            final sizes = (product['size'] as List<dynamic>).join(', ');
            final image=product['image'] as String;

            int quantity = 1;
            bool showCounter = false;

            showDialog(
              context: context,
              builder: (dialogContext) {
                return StatefulBuilder(
                  builder: (context, setDialogState) {
                    return AlertDialog(
                      title: const Text('Product Details'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name),
                          Text('₹ $price'),
                          Text('Available Sizes: $sizes'),
                          const SizedBox(height: 45),
                          if (showCounter)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 120,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      227,
                                      97,
                                      27,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (quantity > 1) {
                                            setDialogState(() {
                                              quantity--;
                                            });
                                          }
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                      Text(
                                        '$quantity',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setDialogState(() {
                                            quantity++;
                                          });
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: const Text('Close'),
                        ),
                        if (!showCounter)
                          TextButton(
                            onPressed: () {
                              setDialogState(() {
                                showCounter = true;
                              });
                            },
                            child: const Text('Add to Cart'),
                          )
                        else
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _cartItemCount += quantity;
                                cartItems.add({
                                  'name': name,
                                  'price': price,
                                  'image': image,
                                  'quantity': quantity,
                                  'title': product['title'],
                                });
                              });
                              Navigator.pop(dialogContext);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '$quantity item${quantity == 1 ? '' : 's'} added to cart',
                                  ),
                                ),
                              );
                            },
                            child: const Text('Done'),
                          ),
                      ],
                    );
                  },
                );
              },
            );
          },
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
          ),
        );
      },
    );
  }
  
}
