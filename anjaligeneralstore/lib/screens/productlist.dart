import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<List<dynamic>> loadProducts() async {
  final data = await rootBundle.loadString('assets/db.json');
  return json.decode(data);
}

class ProductList extends StatelessWidget {
  final String username;

  const ProductList({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello $username"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: loadProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final products = snapshot.data!;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];

              return Card(
                child: Column(
                  children: [
                    Image.asset(p['image']),
                    Text(p['name']),
                    Text("₹${p['price']}"),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
