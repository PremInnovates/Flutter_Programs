import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  SummaryScreen({required this.data});

  double calculateAverageRating() {
    // ✅ FIX 8: Correct summation
    if (data.isEmpty) return 0; // ✅ FIX 9: prevent crash

    int total = 0;

    for (var item in data) {
      total += item["rating"] as int;
    }

    return total / data.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feedback Summary")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Average Rating: ${calculateAverageRating().toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            Divider(),

            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];

                  //  FEATURE: Card UI
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(item["name"]),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Course: ${item["course"]}"),
                          Text("Comments: ${item["comments"]}"),
                        ],
                      ),
                      trailing: Text(
                        "⭐ ${item["rating"]}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
