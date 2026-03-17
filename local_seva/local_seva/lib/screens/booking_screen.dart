import 'package:flutter/material.dart';
import 'package:local_seva/screens/payment_screen.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic>? provider; // Optional provider data
  final String? serviceType; // Optional service type

  const BookingScreen({super.key, this.provider, this.serviceType});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Service selection
  int _selectedServiceIndex = 0;
  final List<Map<String, dynamic>> services = [
    {'name': 'AC Repair', 'icon': Icons.ac_unit, 'basePrice': 399},
    {'name': 'Plumbing', 'icon': Icons.plumbing, 'basePrice': 299},
    {'name': 'Electrical', 'icon': Icons.electrical_services, 'basePrice': 349},
    {'name': 'Cleaning', 'icon': Icons.cleaning_services, 'basePrice': 499},
    {'name': 'Carpentry', 'icon': Icons.handyman, 'basePrice': 449},
    {'name': 'Painting', 'icon': Icons.format_paint, 'basePrice': 599},
  ];

  // Date selection
  int _selectedDateIndex = 2;
  final List<DateTime> availableDates = List.generate(7, (index) {
    return DateTime.now().add(Duration(days: index));
  });

  // Time selection
  int _selectedTimeIndex = 1;
  final List<String> timeSlots = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM',
  ];

  // Address selection
  int _selectedAddressIndex = 0;
  final List<Map<String, dynamic>> savedAddresses = [
    {
      'type': 'Home',
      'address': '123, Green Park Apartments, Andheri East, Mumbai - 400069',
      'icon': Icons.home,
      'isDefault': true,
    },
    {
      'type': 'Office',
      'address': '456, Business Hub, Bandra Kurla Complex, Mumbai - 400051',
      'icon': Icons.business,
      'isDefault': false,
    },
  ];

  // Provider selection (if not passed from previous screen)
  int _selectedProviderIndex = 0;
  final List<Map<String, dynamic>> availableProviders = [
    {'name': 'Ramesh Patel', 'rating': 4.8, 'jobs': 1240, 'price': 299},
    {'name': 'Kunal Mehta', 'rating': 4.9, 'jobs': 980, 'price': 279},
    {'name': 'Suresh Yadav', 'rating': 4.7, 'jobs': 2150, 'price': 349},
  ];

  // Additional services
  bool _needUrgentService = false;
  bool _needMaterial = false;
  bool _needWarranty = false;
  bool _whatsAppUpdates = true;

  // Problem description
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Set selected service if passed
    if (widget.serviceType != null) {
      final index = services.indexWhere((s) => s['name'] == widget.serviceType);
      if (index != -1) {
        _selectedServiceIndex = index;
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Helper method to format date as string
  String _getFormattedDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Book Service",
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF1E3C72),
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color(0xFF1E3C72),
              indicatorWeight: 3,
              tabs: const [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.build_circle, size: 20),
                      SizedBox(width: 4),
                      Text('Service'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month, size: 20),
                      SizedBox(width: 4),
                      Text('Schedule'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.description, size: 20),
                      SizedBox(width: 4),
                      Text('Details'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            color: Colors.white,
            child: Row(
              children: [
                _buildProgressStep(1, 'Service', _tabController.index >= 0),
                _buildProgressLine(),
                _buildProgressStep(2, 'Schedule', _tabController.index >= 1),
                _buildProgressLine(),
                _buildProgressStep(3, 'Details', _tabController.index >= 2),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildServiceTab(),
                _buildScheduleTab(),
                _buildDetailsTab(),
              ],
            ),
          ),

          // Bottom Navigation Buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  if (_tabController.index > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _tabController.animateTo(
                            _tabController.index - 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF1E3C72)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'Back',
                          style: TextStyle(color: Color(0xFF1E3C72)),
                        ),
                      ),
                    ),
                  if (_tabController.index > 0) const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_tabController.index < 2) {
                          _tabController.animateTo(
                            _tabController.index + 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          _navigateToPayment();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3C72),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        _tabController.index == 2
                            ? 'Proceed to Payment'
                            : 'Next',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStep(int step, String label, bool isActive) {
    return Expanded(
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? const Color(0xFF1E3C72) : Colors.grey[300],
            ),
            child: Center(
              child: Text(
                step.toString(),
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xFF1E3C72) : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressLine() {
    return Container(
      width: 20,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: Colors.grey[300],
    );
  }

  Widget _buildServiceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Service',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Service Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              final isSelected = _selectedServiceIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedServiceIndex = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF1E3C72) : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF1E3C72)
                          : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        service['icon'],
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF1E3C72),
                        size: 40,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        service['name'],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹${service['basePrice']}',
                        style: TextStyle(
                          color: isSelected ? Colors.white70 : Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          const Text(
            'Select Provider',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Provider List
          ...List.generate(availableProviders.length, (index) {
            final provider = availableProviders[index];
            final isSelected = _selectedProviderIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedProviderIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF1E3C72).withOpacity(0.05)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1E3C72)
                        : Colors.grey[200]!,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3C72).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        provider['name'][0],
                        style: const TextStyle(
                          color: Color(0xFF1E3C72),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              Text(
                                ' ${provider['rating']} (${provider['jobs']} jobs)',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '₹${provider['price']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF1E3C72),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Date',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Date Picker
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: availableDates.length,
              itemBuilder: (context, index) {
                final date = availableDates[index];
                final isSelected = _selectedDateIndex == index;
                final dayNames = [
                  'Mon',
                  'Tue',
                  'Wed',
                  'Thu',
                  'Fri',
                  'Sat',
                  'Sun',
                ];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDateIndex = index;
                    });
                  },
                  child: Container(
                    width: 70,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF1E3C72)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF1E3C72)
                            : Colors.grey[300]!,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dayNames[date.weekday - 1],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Select Time',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Time Slots
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(timeSlots.length, (index) {
              final isSelected = _selectedTimeIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTimeIndex = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF1E3C72) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF1E3C72)
                          : Colors.grey[300]!,
                    ),
                  ),
                  child: Text(
                    timeSlots[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Service Address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Address List
          ...List.generate(savedAddresses.length, (index) {
            final address = savedAddresses[index];
            final isSelected = _selectedAddressIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedAddressIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF1E3C72).withOpacity(0.05)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1E3C72)
                        : Colors.grey[200]!,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3C72).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        address['icon'],
                        color: const Color(0xFF1E3C72),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                address['type'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (address['isDefault']) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF1E3C72,
                                    ).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    'Default',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF1E3C72),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            address['address'],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Radio(
                      value: index,
                      groupValue: _selectedAddressIndex,
                      onChanged: (value) {
                        setState(() {
                          _selectedAddressIndex = value as int;
                        });
                      },
                      activeColor: const Color(0xFF1E3C72),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 16),

          // Add New Address Button
          OutlinedButton.icon(
            onPressed: () {
              // Add new address
            },
            icon: const Icon(Icons.add, color: Color(0xFF1E3C72)),
            label: const Text(
              'Add New Address',
              style: TextStyle(color: Color(0xFF1E3C72)),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF1E3C72)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(double.infinity, 45),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Problem Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Description Field
          TextField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Describe your problem or special requirements...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: const EdgeInsets.all(16),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Additional Options',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Additional Options
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Urgent Service (within 2 hours)'),
                  subtitle: const Text('Additional ₹100 will be charged'),
                  value: _needUrgentService,
                  onChanged: (value) {
                    setState(() {
                      _needUrgentService = value;
                    });
                  },
                  activeColor: const Color(0xFF1E3C72),
                ),
                const Divider(height: 0),
                SwitchListTile(
                  title: const Text('Need Material/Spare Parts'),
                  subtitle: const Text('Provider will bring required items'),
                  value: _needMaterial,
                  onChanged: (value) {
                    setState(() {
                      _needMaterial = value;
                    });
                  },
                  activeColor: const Color(0xFF1E3C72),
                ),
                const Divider(height: 0),
                SwitchListTile(
                  title: const Text('Service Warranty'),
                  subtitle: const Text('30 days warranty on service'),
                  value: _needWarranty,
                  onChanged: (value) {
                    setState(() {
                      _needWarranty = value;
                    });
                  },
                  activeColor: const Color(0xFF1E3C72),
                ),
                const Divider(height: 0),
                SwitchListTile(
                  title: const Text('WhatsApp Updates'),
                  subtitle: const Text('Get booking updates on WhatsApp'),
                  value: _whatsAppUpdates,
                  onChanged: (value) {
                    setState(() {
                      _whatsAppUpdates = value;
                    });
                  },
                  activeColor: const Color(0xFF1E3C72),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Price Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Base Price'),
                    Text(
                      '₹${services[_selectedServiceIndex]['basePrice']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                if (_needUrgentService) ...[
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Urgent Service Fee'),
                      Text(
                        '+ ₹100',
                        style: TextStyle(color: Colors.green[700]),
                      ),
                    ],
                  ),
                ],
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₹${_calculateTotal()}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3C72),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _calculateTotal() {
    int total = services[_selectedServiceIndex]['basePrice'];
    if (_needUrgentService) {
      total += 100;
    }
    return total;
  }

  void _navigateToPayment() {
    // Create booking data with ONLY primitive types (no complex objects)
    final bookingData = {
      'service': services[_selectedServiceIndex]['name'].toString(),
      'provider': availableProviders[_selectedProviderIndex]['name'].toString(),
      'date': _getFormattedDate(
        availableDates[_selectedDateIndex],
      ), // DateTime to String
      'time': timeSlots[_selectedTimeIndex].toString(),
      'address': savedAddresses[_selectedAddressIndex]['type'].toString(),
      'addressDetails': savedAddresses[_selectedAddressIndex]['address']
          .toString(),
      'description': _descriptionController.text,
      'basePrice': services[_selectedServiceIndex]['basePrice'] as int,
      'urgentFee': _needUrgentService ? 100 : 0,
      'total': _calculateTotal(),
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(bookingData: bookingData),
      ),
    );
  }
}
