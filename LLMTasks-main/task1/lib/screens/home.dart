import 'package:flutter/material.dart';
import 'package:task1/screens/add_expense.dart';

class Expense {
  final double amount;
  final String category;
  Expense(this.amount, this.category);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Expense> expenses = [
    Expense(767, "Food"),
    Expense(9, "Travel"),
    Expense(23, "Snacks"),
  ];
  double get total {
    if (expenses.isEmpty) return 0;
    return expenses.map((e) => e.amount).reduce((a, b) => a + b);
  }

  void addExpense(double value, String category) {
    if (value <= 0) return;

    setState(() {
      expenses.add(Expense(value, category));
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Expense Added")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expense Manager")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Total Expenses: ₹$total", style: TextStyle(fontSize: 24)),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddExpenseScreen(addExpense: addExpense),
                    ),
                  );
                },
                label: Text("Add Expense"),
                icon: Icon(Icons.add),
              ),
            ],
          ),

          Expanded(
            child: expenses.isEmpty
                ? Center(
                    child: Text(
                      "No expenses yet",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: ListTile(
                          title: Text("₹${expenses[index].amount}"),
                          subtitle: Text(expenses[index].category),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                expenses.removeAt(index);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
