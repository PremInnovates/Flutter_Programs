import 'package:flutter/material.dart';
import 'package:set2/screens/summary_screen.dart';

class FeedbackFormScreen extends StatefulWidget {
  const FeedbackFormScreen({super.key});

  @override
  State<FeedbackFormScreen> createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends State<FeedbackFormScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

  String? selectedCourse;
  int rating = 0;

  List<Map<String, dynamic>> feedbackList = [];

  void submitFeedback() {
    //  FIX 1: Removed semicolon + proper validation check
    if (!_formKey.currentState!.validate() || rating == 0) {
      //  Prevent submission if invalid or rating not selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields correctly")),
      );
      return;
    }

    final feedback = {
      "name": nameController.text,
      "course": selectedCourse,
      "rating": rating,
      "comments": commentsController.text,
    };

    //  FIX 2: Wrap in setState to update UI properly
    setState(() {
      feedbackList.add(feedback);
    });

    // FEATURE: SnackBar on success
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Feedback Submitted Successfully!")));

    //  FIX 3: Reset properly using setState
    setState(() {
      nameController.clear(); // FIXED
      commentsController.clear();
      selectedCourse = null;
      rating = 0;
    });

    //  FIX 4: Navigate only after valid submission
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryScreen(data: feedbackList),
      ),
    );
  }

  //  FEATURE: Reset button function
  void resetForm() {
    setState(() {
      nameController.clear();
      commentsController.clear();
      selectedCourse = null;
      rating = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Course Feedback",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          onChanged: () {
            setState(() {}); //  Helps enable/disable button dynamically
          },
          child: Column(
            children: [
              // 🔹 Name Field
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Student Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  //  FIX 5: Proper validation message
                  if (value == null || value.isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
              ),

              SizedBox(height: 10),

              // 🔹 Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(border: OutlineInputBorder()),
                hint: Text("Select Course"),
                value: selectedCourse,
                items: ["CN", "Flutter", "AI", "CWS", "Python"]
                    .map(
                      (course) =>
                          DropdownMenuItem(value: course, child: Text(course)),
                    )
                    .toList(),
                onChanged: (value) {
                  //  FIX 6: Use setState + assignment
                  setState(() {
                    selectedCourse = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Please select course";
                  }
                  return null;
                },
              ),

              SizedBox(height: 10),

              //  Rating Stars
              Row(
                children: [
                  Text("Ratings - "),
                  Row(
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          Icons.star,
                          color: rating > index ? Colors.orange : Colors.grey,
                        ),
                        onPressed: () {
                          // ✅ FIX 7: setState + assignment
                          setState(() {
                            rating = index + 1;
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),

              //  Comments
              TextFormField(
                controller: commentsController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Comments",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),

              //  Submit Button
              ElevatedButton(
                // ✅ FEATURE: Disable if invalid
                onPressed:
                    (_formKey.currentState?.validate() ?? false) && rating > 0
                    ? submitFeedback
                    : null,
                child: Text("Submit Feedback"),
              ),

              SizedBox(height: 10),

              //  Reset Button
              ElevatedButton(
                onPressed: resetForm,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                child: Text("Reset Form"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
