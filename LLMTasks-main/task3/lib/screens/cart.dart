import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final double price;
  int quantity;
  final String imageUrl;

  CartItem({
    required this.name,
    required this.price,
    this.quantity = 1,
    required this.imageUrl,
  });
}

// Global cart list
List<CartItem> cart = [];

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double calculateTotal() {
    double total = 0;
    for (var item in cart) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void addItem(int index) {
    setState(() {
      cart[index].quantity++;
    });
  }

  void removeItem(int index) {
    setState(() {
      if (cart[index].quantity > 1) {
        cart[index].quantity--;
      } else {
        cart.removeAt(index);
      }
    });
  }

  void deleteItem(int index) {
    setState(() {
      cart.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart Page")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                double itemTotal = item.price * item.quantity;

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.network(
                          item.imageUrl,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 50),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("₹${item.price}"),
                              Text("Total: ₹$itemTotal"),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => removeItem(index),
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                              "${item.quantity}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () => addItem(index),
                              icon: const Icon(Icons.add),
                            ),
                            IconButton(
                              onPressed: () => deleteItem(index),
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Grand Total: ₹${calculateTotal()}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}