import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<Map<String, dynamic>> allBookings = [];
  static const String _bookingsKey = 'user_bookings';
  Timer? _statusUpdateTimer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
    _loadBookings();
    _startAutoStatusUpdater();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _statusUpdateTimer?.cancel();
    super.dispose();
  }

  void _startAutoStatusUpdater() {
    _statusUpdateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _checkAndUpdateUpcomingToOngoing();
    });
  }

  Future<void> _checkAndUpdateUpcomingToOngoing() async {
    bool changed = false;
    final now = DateTime.now().millisecondsSinceEpoch;
    for (int i = 0; i < allBookings.length; i++) {
      final booking = allBookings[i];
      if (booking['status'] == 'upcoming') {
        int createdAt = booking['createdAt'] ?? 0;
        if (createdAt > 0 && now - createdAt >= 5000) {
          // 5 seconds
          allBookings[i]['status'] = 'ongoing';
          changed = true;
        }
      }
    }
    if (changed) {
      await _saveBookings();
      setState(() {}); // Refresh UI
    }
  }

  Future<void> _loadBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final String? bookingsJson = prefs.getString(_bookingsKey);

    if (bookingsJson != null) {
      List<dynamic> decoded = jsonDecode(bookingsJson);
      setState(() {
        allBookings = decoded.cast<Map<String, dynamic>>();
      });
    } else {
      List<Map<String, dynamic>> defaultBookings =
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
              'createdAt': DateTime.now().millisecondsSinceEpoch - 60000,
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
              'createdAt': DateTime.now().millisecondsSinceEpoch,
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
              'createdAt': DateTime.now().millisecondsSinceEpoch - 30000,
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
              'createdAt': DateTime.now().millisecondsSinceEpoch - 86400000,
            },
          ];
      setState(() {
        allBookings = defaultBookings;
      });
      await _saveBookings();
    }
  }

  Future<void> _saveBookings() async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(allBookings);
    await prefs.setString(_bookingsKey, jsonString);
  }

  Future<void> _updateBooking(
    int index,
    Map<String, dynamic> updatedBooking,
  ) async {
    setState(() {
      allBookings[index] = updatedBooking;
    });
    await _saveBookings();
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
      case 0:
        return currentBookings;
      case 1:
        return previousBookings;
      default:
        return allBookings;
    }
  }

  // ================== BUILD METHOD ==================
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
          Expanded(
            child: filteredBookings.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredBookings.length,
                    itemBuilder: (context, index) {
                      final booking = filteredBookings[index];
                      final originalIndex = allBookings.indexWhere(
                        (b) => b['id'] == booking['id'],
                      );
                      return _buildBookingCard(booking, originalIndex);
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

  Widget _buildBookingCard(Map<String, dynamic> booking, int originalIndex) {
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
      onTap: () => _showBookingDetails(context, booking),
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[200]!)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _getActionButtons(booking, originalIndex),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getActionButtons(
    Map<String, dynamic> booking,
    int originalIndex,
  ) {
    List<Widget> buttons = [];

    if (booking['status'] == 'upcoming') {
      buttons.addAll([
        _buildActionButton(
          icon: Icons.cancel,
          label: 'Cancel',
          color: Colors.red,
          onTap: () => _showCancelDialog(booking, originalIndex),
        ),
        const SizedBox(width: 8),
      ]);
    }

    if (booking['status'] == 'ongoing') {
      buttons.addAll([
        _buildActionButton(
          icon: Icons.check_circle,
          label: 'Complete',
          color: Colors.green,
          onTap: () => _completeBooking(booking, originalIndex),
        ),
        const SizedBox(width: 8),
      ]);
    }

    if (booking['status'] == 'completed' && booking['rating'] == null) {
      buttons.add(
        _buildActionButton(
          icon: Icons.star,
          label: 'Rate',
          color: Colors.amber,
          onTap: () => _showRatingDialog(booking, originalIndex),
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

  Future<void> _completeBooking(Map<String, dynamic> booking, int index) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Complete Service'),
        content: Text('Mark this ${booking['service']} booking as completed?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Yes, Complete'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      Map<String, dynamic> updated = Map.from(booking);
      updated['status'] = 'completed';
      await _updateBooking(index, updated);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Service completed!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _showCancelDialog(Map<String, dynamic> booking, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
            onPressed: () async {
              Map<String, dynamic> updated = Map.from(booking);
              updated['status'] = 'cancelled';
              await _updateBooking(index, updated);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking cancelled'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  void _showRatingDialog(Map<String, dynamic> booking, int index) {
    int rating = 0;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Rate Your Experience'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('How was your service with ${booking['provider']}?'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (i) => IconButton(
                    icon: Icon(
                      i < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 32,
                    ),
                    onPressed: () => setStateDialog(() => rating = i + 1),
                  ),
                ),
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
                  ? () async {
                      Map<String, dynamic> updated = Map.from(booking);
                      updated['rating'] = rating;
                      await _updateBooking(index, updated);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Thank you for rating!')),
                      );
                    }
                  : null,
              child: const Text('Submit'),
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
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3C72),
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
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
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
        ),
      ),
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
}
