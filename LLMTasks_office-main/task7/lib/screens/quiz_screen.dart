import 'package:flutter/material.dart';
import 'package:task7/screens/result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
 List<Map<String, dynamic>> questions = [
    {
      "question": "Capital of France?",
      "options": ["Berlin", "Paris", "Rome"],
      "answer": "Paris",
      "selected": ""
    },
    {
      "question": "5 + 3 = ?",
      "options": ["6", "8", "10"],
      "answer": "8",
      "selected": ""
    }
  ];

  int score = 0;

  void calculateScore() {
    for (var q in questions) {
      if (q["selected"] == q["answer"]) {
        score = score++; // 😈 BUG
      }
    }
  }

  void goToResult() {
    calculateScore();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(), // 😈 BUG (no score passed)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mini Quiz")),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Text(
                  questions[index]["question"],
                  style: TextStyle(fontSize: 18),
                ),
                ...questions[index]["options"].map<Widget>((option) {
                  return RadioListTile(
                    title: Text(option),
                    value: option,
                    groupValue: questions[index]["selected"],
                    onChanged: (value) {
                      questions[index]["selected"] = value;
                      // 😈 BUG (no setState)
                    },
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToResult,
        child: Icon(Icons.check),
      ),
    );
  }
}