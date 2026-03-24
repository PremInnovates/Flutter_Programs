import 'package:flutter/material.dart';
import 'package:set3/screens/add_item_screen.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<Map<String, dynamic>> items = [
    {"name": "Pen", "qty": 5},
    {"name": "Notebook", "qty": 2},
  ];

  void increaseQty(int index) {
    setState(() {
      items[index]["qty"] = items[index]["qty"] + 1; // FIX: proper assignment
    });

    // FEATURE: show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Stock increased")),
    );
  }

  void decreaseQty(int index) {
    if (items[index]["qty"] > 0) {
      setState(() {
        items[index]["qty"]--; // FIX: wrapped in setState
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Stock decreased")),
      );
    }
  }

  int getTotalStock() {
    int total = 0;
    for (var item in items) {
      total += item["qty"] as int; // FIX: sum instead of overwrite
    }
    return total;
  }

  void goToAddItem() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddItemScreen()),
    );

    if (result != null) {
      setState(() {
        items.add(result); // FIX: wrap in setState so UI updates
      });
    }
  }

  bool isLowStock(int qty) {
    return qty <= 2; // FIX: improved condition
  }

  // FEATURE: reset all stock
  void resetStock() {
    setState(() {
      for (var item in items) {
        item["qty"] = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Stock: ${getTotalStock()} | Items: ${items.length}", // FEATURE
        ),
        actions: [
          IconButton(
            onPressed: resetStock, // FEATURE: reset button
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToAddItem,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return Card( // FEATURE: card UI
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                item["name"],
                style: TextStyle(
                  color: isLowStock(item["qty"])
                      ? Colors.red // FEATURE: highlight low stock
                      : Colors.black,
                ),
              ),
              subtitle: Text("Quantity: ${item["qty"]}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    // FEATURE: disable when 0
                    onPressed: item["qty"] == 0
                        ? null
                        : () {
                            decreaseQty(index);
                          },
                  ),

                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      increaseQty(index);
                    },
                  ),

                  if (isLowStock(item["qty"]))
                    Icon(Icons.warning, color: Colors.red) // low stock icon
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}