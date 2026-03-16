import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  final Function(double, String) addExpense;
  const AddExpenseScreen({required this.addExpense, super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final categoryController = TextEditingController();

  void saveExpense() {
    if (_formKey.currentState!.validate()) {
      double value = double.parse(controller.text);
      String category = categoryController.text;
      widget.addExpense(value, category);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(label: Text("Enter Expense")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter amount";
                  }
                  if (double.tryParse(value) == null) {
                    return "Enter valid number";
                  }
                  if (double.parse(value) <= 0) {
                    return "Invalid amount";
                  }
                },
              ),

              SizedBox(height: 20),

              ElevatedButton(onPressed: saveExpense, child: Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
