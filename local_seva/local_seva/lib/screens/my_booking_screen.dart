import 'package:flutter/material.dart';
import 'booking_success_screen.dart';
import 'provider_profile_screen.dart';

class MyBookingsScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? initialBookings;

  const MyBookingsScreen({super.key, this.initialBookings});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  // Bookings list - will be populated from widget or defaults
  late List<Map<String, dynamic>> allBookings;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });

    // Initialize with passed bookings or defaults
    allBookings =
        widget.initialBookings ??
        [
          {
            'id': 'BK001',
            'service': 'AC Repair',
            'provider': 'Ramesh Patel',
            'providerImage': 'RP',
            'date': '15 Mar 2026',
            'time': '10:00 AM',
            'amount': 499,
            'status': 'completed',
            'rating': 5,
            'address': 'Home',
            'paymentMethod': 'Cash on Service',
          },
          {
            'id': 'BK002',
            'service': 'Plumbing',
            'provider': 'Suresh Yadav',
            'providerImage': 'SY',
            'date': '18 Mar 2026',
            'time': '2:00 PM',
            'amount': 399,
            'status': 'upcoming',
            'rating': null,
            'address': 'Office',
            'paymentMethod': 'Cash on Service',
          },
          {
            'id': 'BK003',
            'service': 'Cleaning',
            'provider': 'Priya Sharma',
            'providerImage': 'PS',
            'date': '10 Mar 2026',
            'time': '11:00 AM',
            'amount': 599,
            'status': 'ongoing',
            'rating': null,
            'address': 'Home',
            'paymentMethod': 'Cash on Service',
          },
          {
            'id': 'BK004',
            'service': 'Electrical',
            'provider': 'Amit Kumar',
            'providerImage': 'AK',
            'date': '05 Mar 2026',
            'time': '3:00 PM',
            'amount': 349,
            'status': 'cancelled',
            'rating': null,
            'address': 'Home',
            'paymentMethod': 'Cash on Service',
          },
        ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get currentBookings {
    return allBookings
        .where((b) => b['status'] == 'upcoming' || b['status'] == 'ongoing')
        .toList();
  }

  List<Map<String, dynamic>> get previousBookings {
    return allBookings
        .where((b) => b['status'] == 'completed' || b['status'] == 'cancelled')
        .toList();
  }

  List<Map<String, dynamic>> get filteredBookings {
    switch (_selectedTabIndex) {
      case 0: // Current
        return currentBookings;
      case 1: // Previous
        return previousBookings;
      default:
        return allBookings;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "My Bookings",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          tabs: const [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_available, size: 18),
                  SizedBox(width: 4),
                  Text('Current'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 18),
                  SizedBox(width: 4),
                  Text('Previous'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Stats Summary
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  Icons.event_available,
                  "Current",
                  currentBookings.length.toString(),
                  Colors.blue,
                ),
                _buildStatItem(
                  Icons.history,
                  "Previous",
                  previousBookings.length.toString(),
                  Colors.green,
                ),
                _buildStatItem(
                  Icons.credit_card,
                  "Total Spent",
                  "₹${_calculateTotalSpent()}",
                  Colors.orange,
                ),
              ],
            ),
          ),

          // Booking List
          Expanded(
            child: filteredBookings.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredBookings.length,
                    itemBuilder: (context, index) {
                      return _buildBookingCard(filteredBookings[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    IconData icon,
    String label,
    String count,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 4),
        Text(
          count,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
      ],
    );
  }

  String _calculateTotalSpent() {
    int total = 0;
    for (var booking in allBookings) {
      if (booking['status'] == 'completed') {
        total += booking['amount'] as int;
      }
    }
    return total.toString();
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    Color statusColor;
    IconData statusIcon;

    switch (booking['status']) {
      case 'completed':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'upcoming':
        statusColor = Colors.blue;
        statusIcon = Icons.schedule;
        break;
      case 'ongoing':
        statusColor = Colors.orange;
        statusIcon = Icons.autorenew;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help;
    }

    return GestureDetector(
      onTap: () {
        _showBookingDetails(context, booking);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Top Section with Status
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.05),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(statusIcon, color: statusColor, size: 16),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        booking['status'].toUpperCase(),
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "ID: ${booking['id']}",
                    style: TextStyle(color: Colors.grey[500], fontSize: 11),
                  ),
                ],
              ),
            ),

            // Main Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Provider Image
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E3C72).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        booking['providerImage'] ?? booking['provider'][0],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3C72),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Booking Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking['service'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          booking['provider'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 12,
                              color: Colors.grey[500],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              booking['date'],
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.access_time,
                              size: 12,
                              color: Colors.grey[500],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              booking['time'],
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Price
                  Column(
                    children: [
                      Text(
                        '₹${booking['amount']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF1E3C72),
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (booking['rating'] != null)
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                            Text(
                              ' ${booking['rating']}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Bottom Actions
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[200]!)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _getActionButtons(booking),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getActionButtons(Map<String, dynamic> booking) {
    List<Widget> buttons = [];

    if (booking['status'] == 'upcoming') {
      buttons.addAll([
        _buildActionButton(
          icon: Icons.cancel,
          label: 'Cancel',
          color: Colors.red,
          onTap: () => _showCancelDialog(booking),
        ),
        const SizedBox(width: 8),
      ]);
    } else if (booking['status'] == 'completed' && booking['rating'] == null) {
      buttons.add(
        _buildActionButton(
          icon: Icons.star,
          label: 'Rate',
          color: Colors.amber,
          onTap: () => _showRatingDialog(booking),
        ),
      );
    }

    buttons.add(
      _buildActionButton(
        icon: Icons.info_outline,
        label: 'Details',
        color: Colors.grey[700]!,
        onTap: () => _showBookingDetails(context, booking),
      ),
    );

    return buttons;
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _selectedTabIndex == 0 ? Icons.event_busy : Icons.history,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            _selectedTabIndex == 0
                ? 'No current bookings'
                : 'No previous bookings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedTabIndex == 0
                ? 'Your active bookings will appear here'
                : 'Your completed bookings will appear here',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
          if (_selectedTabIndex == 0) const SizedBox(height: 20),
          if (_selectedTabIndex == 0)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3C72),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Book a Service'),
            ),
        ],
      ),
    );
  }

  void _showBookingDetails(BuildContext context, Map<String, dynamic> booking) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(20),
                      children: [
                        const Text(
                          'Booking Details',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Provider Info
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E3C72).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  booking['providerImage'] ??
                                      booking['provider'][0],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E3C72),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    booking['provider'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    booking['service'],
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Details Grid
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              _buildDetailRow(
                                Icons.calendar_today,
                                'Date',
                                booking['date'],
                              ),
                              _buildDetailRow(
                                Icons.access_time,
                                'Time',
                                booking['time'],
                              ),
                              _buildDetailRow(
                                Icons.location_on,
                                'Location',
                                booking['address'],
                              ),
                              _buildDetailRow(
                                Icons.payment,
                                'Payment',
                                booking['paymentMethod'],
                              ),
                              _buildDetailRow(
                                Icons.currency_rupee,
                                'Amount',
                                '₹${booking['amount']}',
                              ),
                              _buildDetailRow(
                                Icons.confirmation_number,
                                'Booking ID',
                                booking['id'],
                              ),
                              _buildDetailRow(
                                Icons.info,
                                'Status',
                                booking['status'].toUpperCase(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color(0xFF1E3C72)),
          const SizedBox(width: 12),
          SizedBox(
            width: 80,
            child: Text(label, style: TextStyle(color: Colors.grey[600])),
          ),
          Text(
            ':  $value',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Cancel Booking'),
          content: Text(
            'Are you sure you want to cancel your ${booking['service']} booking?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  booking['status'] = 'cancelled';
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Booking cancelled successfully'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Yes, Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showRatingDialog(Map<String, dynamic> booking) {
    int rating = 0;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text('Rate Your Experience'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'How was your service with ${booking['provider']}?',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 32,
                        ),
                        onPressed: () {
                          setState(() {
                            rating = index + 1;
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Skip'),
                ),
                ElevatedButton(
                  onPressed: rating > 0
                      ? () {
                          setState(() {
                            booking['rating'] = rating;
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Thank you for your rating!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3C72),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
