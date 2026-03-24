import 'package:flutter/material.dart';
import 'package:set4/screens/confrimation_screen.dart';

class SlotScreen extends StatefulWidget {
  const SlotScreen({super.key});

  @override
  State<SlotScreen> createState() => _SlotScreenState();
}

class _SlotScreenState extends State<SlotScreen> {
  List<Map<String, dynamic>> slots = List.generate(
    12,
    (index) => {"time": "${9 + index}:00", "booked": index % 4 == 0},
  );

  int? selectedIndex;

  void selectSlot(int index) {
    // FIX: prevent selecting booked slots
    if (!slots[index]["booked"]) {
      setState(() {
        selectedIndex = index; // FIX: assignment instead of ==
      });
    }
  }

  void confirmBooking() {
  if (selectedIndex == null) return;

  // store selected slot before resetting
  final selectedTime = slots[selectedIndex!]["time"]; // FIX

  setState(() {
    slots[selectedIndex!]["booked"] = true; // FIX: update UI
    selectedIndex = null; // FIX: reset selection
  });

  // show confirmation message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Slot booked successfully")),
  );

  // navigate to confirmation screen
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ConfirmationScreen(
        slotTime: selectedTime, // FIX: correct value
      ),
    ),
  );
}
  int getAvailableSlots() {
    int count = 0;

    for (var slot in slots) {
      // FIX: correct counting logic
      if (!slot["booked"]) {
        count++;
      }
    }

    return count;
  }

  Color getSlotColor(int index) {
    if (slots[index]["booked"]) {
      return Colors.grey; // booked
    }
    if (selectedIndex == index) {
      return Colors.green; // selected
    }
    return Colors.blue; // available
  }

  // FEATURE: reset selection only
  void resetSelection() {
    setState(() {
      selectedIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Slots: ${getAvailableSlots()}"), // dynamic count
        actions: [
          IconButton(
            onPressed: resetSelection, // FEATURE
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: slots.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: slots[index]["booked"]
                      ? null // FEATURE: disable booked slots
                      : () {
                          selectSlot(index);
                        },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: getSlotColor(index),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      slots[index]["time"],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),

          ElevatedButton(
            // FEATURE: disable if no selection
            onPressed: selectedIndex == null ? null : confirmBooking,
            child: Text("Confirm Booking"),
          ),

          SizedBox(height: 10),

          // FEATURE: reset button
          ElevatedButton(
            onPressed: resetSelection,
            child: Text("Reset Selection"),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
