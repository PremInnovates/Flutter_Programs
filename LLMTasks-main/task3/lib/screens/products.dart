import 'package:flutter/material.dart';
import 'package:task3/screens/cart.dart';

class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({required this.name, required this.price, required this.imageUrl});
}

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> products = [
    Product(
      name: 'Laptop',
      price: 45000,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Phone',
      price: 25000,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Headphones',
      price: 3000,
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  void addToCart(Product product) {
    final existingIndex = cart.indexWhere((item) => item.name == product.name);
    if (existingIndex != -1) {
      setState(() {
        cart[existingIndex].quantity++;
      });
    } else {
      setState(() {
        cart.add(
          CartItem(
            name: product.name,
            price: product.price,
            imageUrl: product.imageUrl,
          ),
        );
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} added to the cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                },
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      '${cart.length}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Image.network(
                product.imageUrl,
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 50),
              ),
              title: Text(product.name),
              subtitle: Text('₹ ${product.price}'),
              trailing: ElevatedButton(
                onPressed: () => addToCart(product),
                child: const Text('Add'),
              ),
            ),
          );
        },
      ),
    );
  }
}
