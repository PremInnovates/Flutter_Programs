import 'package:flutter/material.dart';
import 'package:task6/screens/summary_screen.dart';

class TokenScreen extends StatefulWidget {
  const TokenScreen({super.key});

  @override
  State<TokenScreen> createState() => _TokenScreenState();
}

class _TokenScreenState extends State<TokenScreen> {
 int tokenNumber = 1;

  List<int> queue = [];

  void generateToken() {
    tokenNumber = tokenNumber++; // 😈 BUG (increment failure)

    queue.add(tokenNumber); // 😈 BUG (wrong value added)
  }

  void callNext() {
    queue.removeAt(0); // 😈 BUG (crash if empty)
  }

  int getQueueLength() {
    int length = 0;

    for (var token in queue) {
      length = queue.length; // 😈 BUG (unnecessary loop misuse)
    }

    return length;
  }

  void goToSummary() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryScreen(
          totalTokens: tokenNumber,
          queueLength: getQueueLength(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Queue Token System")),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Current Token: $tokenNumber",
            style: TextStyle(fontSize: 22),
          ),
          Divider(),
          ElevatedButton(
            onPressed: generateToken, // 😈 BUG (no setState)
            child: Text("Generate Token"),
          ),
          Divider(),
          Text(
            "Queue Length: ${getQueueLength()}",
            style: TextStyle(fontSize: 18),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: queue.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Token ${queue[index]}"),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: callNext, // 😈 BUG (no safety check)
            child: Text("Call Next"),
          ),
          ElevatedButton(
            onPressed: goToSummary,
            child: Text("View Summary"),
          )
        ],
      ),
    );
  }
}
