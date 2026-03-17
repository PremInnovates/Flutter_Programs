import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'my_booking_screen.dart';

class BookingSuccessScreen extends StatelessWidget {
  final Map<String, dynamic>? bookingDetails;

  const BookingSuccessScreen({super.key, this.bookingDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          // Animated Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF1E3C72).withOpacity(0.1),
                  const Color(0xFF2A5298).withOpacity(0.05),
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Confetti Effect
          ...List.generate(20, (index) {
            return Positioned(
              top: (index * 30) % 800,
              left: (index * 40) % 400,
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(seconds: 2 + index),
                curve: Curves.easeInOut,
                builder: (context, double value, child) {
                  return Opacity(
                    opacity: (1 - value).clamp(0.0, 0.3),
                    child: Transform.translate(
                      offset: Offset(0, -50 * value),
                      child: Icon(
                        Icons.star,
                        color: [
                          Colors.amber,
                          Colors.blue,
                          Colors.green,
                          Colors.purple,
                        ][index % 4],
                        size: 10 + (index % 10).toDouble(),
                      ),
                    ),
                  );
                },
              ),
            );
          }),

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    // Success Animation
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.elasticOut,
                      builder: (context, double value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF1E3C72,
                                  ).withOpacity(0.3),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                              size: 80,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 40),

                    // Success Text
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOut,
                      builder: (context, double value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: Column(
                              children: [
                                const Text(
                                  "Booking Successful!",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E3C72),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "Your service has been booked successfully",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 40),

                    // Booking Details Card
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOut,
                      builder: (context, double value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 30 * (1 - value)),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    "Booking Details",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  _buildDetailRow(
                                    Icons.build,
                                    "Service",
                                    bookingDetails?['service'] ?? "AC Repair",
                                  ),
                                  _buildDetailRow(
                                    Icons.person,
                                    "Provider",
                                    bookingDetails?['provider'] ??
                                        "Ramesh Patel",
                                  ),
                                  _buildDetailRow(
                                    Icons.calendar_today,
                                    "Date & Time",
                                    _formatDateTime(bookingDetails),
                                  ),
                                  _buildDetailRow(
                                    Icons.location_on,
                                    "Location",
                                    bookingDetails?['address'] ?? "Home",
                                  ),
                                  _buildDetailRow(
                                    Icons.currency_rupee,
                                    "Total Amount",
                                    "₹${bookingDetails?['amount'] ?? 499}",
                                  ),
                                  const Divider(height: 24),
                                  _buildDetailRow(
                                    Icons.confirmation_number,
                                    "Booking ID",
                                    bookingDetails?['bookingId'] ??
                                        "#BK${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
                                    isHighlight: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    // Action Buttons
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.easeOut,
                      builder: (context, double value, child) {
                        return Opacity(
                          opacity: value,
                          child: Column(
                            children: [
                              // Track Order Button
                              SizedBox(
                                width: double.infinity,
                                height: 55,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    _showTrackOrderDialog(context);
                                  },
                                  icon: const Icon(Icons.track_changes),
                                  label: const Text(
                                    "Track Order",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1E3C72),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              // View My Bookings Button - FIXED
                              SizedBox(
                                width: double.infinity,
                                height: 55,
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    // Create a booking object for the current booking
                                    final currentBooking = {
                                      'id':
                                          bookingDetails?['bookingId'] ??
                                          'BK${DateTime.now().millisecondsSinceEpoch}',
                                      'service':
                                          bookingDetails?['service'] ??
                                          'AC Repair',
                                      'provider':
                                          bookingDetails?['provider'] ??
                                          'Ramesh Patel',
                                      'providerImage':
                                          (bookingDetails?['provider']?[0] ??
                                          'R')[0],
                                      'date': _extractDate(
                                        bookingDetails?['dateTime'],
                                      ),
                                      'time': _extractTime(
                                        bookingDetails?['dateTime'],
                                      ),
                                      'amount':
                                          bookingDetails?['amount'] ?? 499,
                                      'status': 'upcoming',
                                      'rating': null,
                                      'address':
                                          bookingDetails?['address'] ?? 'Home',
                                      'paymentMethod':
                                          bookingDetails?['paymentMethod'] ??
                                          'Cash on Service',
                                    };

                                    // Navigate to MyBookingsScreen with the current booking
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyBookingsScreen(
                                          initialBookings: [currentBooking],
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.list_alt),
                                  label: const Text(
                                    "View My Bookings",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFF1E3C72),
                                    side: const BorderSide(
                                      color: Color(0xFF1E3C72),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Back to Home Button
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                    (route) => false,
                                  );
                                },
                                child: const Text(
                                  "Back to Home",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to format date and time
  String _formatDateTime(Map<String, dynamic>? details) {
    if (details == null) return "15 Mar 2024, 10:00 AM";

    String date = details['date'] ?? "15 Mar 2024";
    String time = details['time'] ?? "10:00 AM";
    return "$date, $time";
  }

  // Extract date from dateTime string
  String _extractDate(String? dateTime) {
    if (dateTime == null) return "15 Mar 2024";
    if (dateTime.contains(',')) {
      return dateTime.split(',')[0].trim();
    }
    return dateTime;
  }

  // Extract time from dateTime string
  String _extractTime(String? dateTime) {
    if (dateTime == null) return "10:00 AM";
    if (dateTime.contains(',')) {
      return dateTime.split(',')[1].trim();
    }
    return "10:00 AM";
  }

  // Show track order dialog
  void _showTrackOrderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Track Order'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_on, color: Color(0xFF1E3C72), size: 40),
              const SizedBox(height: 16),
              const Text(
                'Your service provider is on the way!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.access_time, size: 16),
                    SizedBox(width: 8),
                    Text('Estimated arrival: 30 mins'),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value, {
    bool isHighlight = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFF1E3C72).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 16,
              color: isHighlight ? Colors.green : const Color(0xFF1E3C72),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
                color: isHighlight ? Colors.green : Colors.black87,
                fontSize: isHighlight ? 15 : 14,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
