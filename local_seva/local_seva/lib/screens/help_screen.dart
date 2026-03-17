import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  List<Map<String, dynamic>> filteredFAQs = [];

  final List<Map<String, dynamic>> faqCategories = [
    {'id': 1, 'name': 'Booking', 'icon': Icons.book_online, 'count': 8},
    {'id': 2, 'name': 'Payment', 'icon': Icons.payment, 'count': 6},
    {'id': 3, 'name': 'Services', 'icon': Icons.build, 'count': 5},
    {'id': 4, 'name': 'Account', 'icon': Icons.account_circle, 'count': 4},
    {'id': 5, 'name': 'Technical', 'icon': Icons.computer, 'count': 3},
  ];

  final List<Map<String, dynamic>> allFAQs = [
    {
      'id': 1,
      'question': 'How do I book a service?',
      'answer':
          'To book a service, simply go to the home screen, select the service you need, choose a provider, select date and time, and confirm your booking. You can also book directly from provider profiles.',
      'category': 'Booking',
      'views': 1245,
    },
    {
      'id': 2,
      'question': 'What payment methods are accepted?',
      'answer':
          'We accept multiple payment methods including Credit/Debit Cards, UPI (Google Pay, PhonePe, Paytm), Net Banking, and Cash on Service. All online payments are secure and encrypted.',
      'category': 'Payment',
      'views': 987,
    },
    {
      'id': 3,
      'question': 'Can I cancel my booking?',
      'answer':
          'Yes, you can cancel your booking up to 2 hours before the scheduled time without any cancellation fee. Cancellations within 2 hours may incur a small fee. You can cancel from the My Bookings section.',
      'category': 'Booking',
      'views': 756,
    },
    {
      'id': 4,
      'question': 'How do I contact my service provider?',
      'answer':
          'Once your booking is confirmed, you can contact the provider through the app. Go to My Bookings, select your booking, and you\'ll find the contact option there.',
      'category': 'Services',
      'views': 623,
    },
    {
      'id': 5,
      'question': 'What if I\'m not satisfied with the service?',
      'answer':
          'If you\'re not satisfied with the service, you can raise a complaint within 24 hours of service completion. We have a dedicated support team that will investigate and resolve your issue.',
      'category': 'Services',
      'views': 512,
    },
    {
      'id': 6,
      'question': 'How do I reset my password?',
      'answer':
          'To reset your password, go to the login screen, click on "Forgot Password", enter your registered email, and follow the instructions sent to your email.',
      'category': 'Account',
      'views': 489,
    },
    {
      'id': 7,
      'question': 'Is my payment information secure?',
      'answer':
          'Yes, all payment information is encrypted using industry-standard SSL technology. We never store your complete payment details on our servers.',
      'category': 'Payment',
      'views': 434,
    },
    {
      'id': 8,
      'question': 'Can I reschedule my booking?',
      'answer':
          'Yes, you can reschedule your booking up to 2 hours before the scheduled time. Go to My Bookings, select the booking, and click on Reschedule to choose a new time slot.',
      'category': 'Booking',
      'views': 398,
    },
    {
      'id': 9,
      'question': 'How do I update my profile information?',
      'answer':
          'You can update your profile information by going to the Profile screen and clicking on the Edit Profile button. You can update your name, phone number, and address.',
      'category': 'Account',
      'views': 367,
    },
    {
      'id': 10,
      'question': 'What if the provider doesn\'t show up?',
      'answer':
          'If the provider doesn\'t show up at the scheduled time, please contact our support immediately. We will arrange an alternative provider or issue a full refund.',
      'category': 'Services',
      'views': 345,
    },
    {
      'id': 11,
      'question': 'How do I get an invoice for my service?',
      'answer':
          'Invoices are automatically generated and available in the My Bookings section. Select your completed booking and click on "Invoice" to download or view it.',
      'category': 'Payment',
      'views': 312,
    },
    {
      'id': 12,
      'question': 'Why is the app not loading properly?',
      'answer':
          'If the app is not loading properly, try these steps: 1. Check your internet connection 2. Restart the app 3. Clear app cache 4. Update to the latest version 5. Contact support if the issue persists.',
      'category': 'Technical',
      'views': 289,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    filteredFAQs = allFAQs;

    _searchController.addListener(() {
      _filterFAQs();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _filterFAQs() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredFAQs = allFAQs;
      } else {
        filteredFAQs = allFAQs.where((faq) {
          return faq['question'].toLowerCase().contains(query) ||
              faq['answer'].toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Help & Support",
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
                  Icon(Icons.help_outline, size: 20),
                  SizedBox(width: 4),
                  Text('FAQs'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.support_agent, size: 20),
                  SizedBox(width: 4),
                  Text('Contact'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.report_problem, size: 20),
                  SizedBox(width: 4),
                  Text('Report'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildFAQTab(), _buildContactTab(), _buildReportTab()],
      ),
    );
  }

  // FAQ Tab
  Widget _buildFAQTab() {
    return Column(
      children: [
        // Search Bar
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search FAQs...",
              prefixIcon: const Icon(Icons.search, color: Color(0xFF1E3C72)),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),

        // FAQ Categories
        Container(
          height: 100,
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: faqCategories.length,
            itemBuilder: (context, index) {
              final category = faqCategories[index];
              return _buildCategoryChip(category);
            },
          ),
        ),

        // FAQ List
        Expanded(
          child: filteredFAQs.isEmpty
              ? _buildEmptySearchState()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredFAQs.length,
                  itemBuilder: (context, index) {
                    return _buildFAQItem(filteredFAQs[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          filteredFAQs = allFAQs
              .where((faq) => faq['category'] == category['name'])
              .toList();
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1E3C72).withOpacity(0.1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: const Color(0xFF1E3C72).withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(category['icon'], color: const Color(0xFF1E3C72), size: 18),
            const SizedBox(width: 8),
            Text(
              category['name'],
              style: const TextStyle(
                color: Color(0xFF1E3C72),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Color(0xFF1E3C72),
                shape: BoxShape.circle,
              ),
              child: Text(
                category['count'].toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(Map<String, dynamic> faq) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF1E3C72).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.help_outline,
            color: Color(0xFF1E3C72),
            size: 20,
          ),
        ),
        title: Text(
          faq['question'],
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        subtitle: Row(
          children: [
            Icon(Icons.remove_red_eye, size: 12, color: Colors.grey[500]),
            const SizedBox(width: 4),
            Text(
              '${faq['views']} views',
              style: TextStyle(fontSize: 11, color: Colors.grey[500]),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3C72).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                faq['category'],
                style: TextStyle(
                  fontSize: 10,
                  color: const Color(0xFF1E3C72),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              faq['answer'],
              style: TextStyle(color: Colors.grey[700], height: 1.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    // Mark as helpful
                  },
                  icon: const Icon(Icons.thumb_up, size: 16),
                  label: const Text('Helpful'),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {
                    // Mark as not helpful
                  },
                  icon: const Icon(Icons.thumb_down, size: 16),
                  label: const Text('Not Helpful'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearchState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No FAQs found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with different keywords',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _searchController.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3C72),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Clear Search'),
          ),
        ],
      ),
    );
  }

  // Contact Tab
  Widget _buildContactTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Contact Cards
          Row(
            children: [
              Expanded(
                child: _buildContactCard(
                  icon: Icons.phone,
                  title: 'Call Us',
                  subtitle: 'Toll Free',
                  value: '1800-123-4567',
                  color: Colors.green,
                  onTap: () => _launchPhone('18001234567'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildContactCard(
                  icon: Icons.email,
                  title: 'Email Us',
                  subtitle: '24/7 Support',
                  value: 'support@localseva.com',
                  color: Colors.blue,
                  onTap: () => _launchEmail('support@localseva.com'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Live Chat Card
          _buildLiveChatCard(),

          const SizedBox(height: 24),

          // Office Address
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Our Office',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3C72).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: Color(0xFF1E3C72),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Local Seva Headquarters',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '123, Tech Park, Andheri East,\nMumbai, Maharashtra - 400069',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3C72).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.access_time,
                        color: Color(0xFF1E3C72),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Business Hours',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Monday - Saturday: 9:00 AM - 8:00 PM\nSunday: 10:00 AM - 6:00 PM',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Social Media
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Connect With Us',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSocialButton(Icons.facebook, Colors.blue, () {}),
                    _buildSocialButton(Icons.telegram, Colors.lightBlue, () {}),
                    _buildSocialButton(Icons.camera_alt, Colors.pink, () {}),
                    _buildSocialButton(Icons.snapchat, Colors.yellow, () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
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
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              subtitle,
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveChatCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3C72).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Live Chat Support',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Chat with our support team instantly',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    // Start live chat
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1E3C72),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Start Chat'),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.chat, color: Colors.white, size: 40),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }

  // Report Tab
  Widget _buildReportTab() {
    String? selectedIssueType; // FIX 1: Added variable for dropdown
    String? selectedPriority = 'Medium'; // FIX 2: Added variable for priority

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Report Form
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Report an Issue',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Booking ID
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Booking ID (Optional)',
                    hintText: 'e.g., BK001234',
                    prefixIcon: const Icon(
                      Icons.confirmation_number,
                      color: Color(0xFF1E3C72),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Issue Type - FIX 3: Added onChanged and value
                DropdownButtonFormField<String>(
                  value: selectedIssueType,
                  decoration: InputDecoration(
                    labelText: 'Issue Type',
                    prefixIcon: const Icon(
                      Icons.error_outline,
                      color: Color(0xFF1E3C72),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'service',
                      child: Text('Service Issue'),
                    ),
                    DropdownMenuItem(
                      value: 'payment',
                      child: Text('Payment Issue'),
                    ),
                    DropdownMenuItem(
                      value: 'provider',
                      child: Text('Provider Issue'),
                    ),
                    DropdownMenuItem(
                      value: 'technical',
                      child: Text('Technical Issue'),
                    ),
                    DropdownMenuItem(value: 'other', child: Text('Other')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedIssueType = value;
                    });
                  },
                ),

                const SizedBox(height: 16),

                // Description
                TextField(
                  controller: _messageController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Describe your issue',
                    hintText:
                        'Please provide detailed information about your issue...',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Attach Image Button
                OutlinedButton.icon(
                  onPressed: () {
                    // Attach image
                  },
                  icon: const Icon(Icons.attach_file),
                  label: const Text('Attach Screenshot'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF1E3C72)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Priority - FIX 4: Added state management
                const Text(
                  'Priority',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildPriorityChip(
                        'Low',
                        Colors.green,
                        selectedPriority == 'Low',
                        () {
                          setState(() {
                            selectedPriority = 'Low';
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildPriorityChip(
                        'Medium',
                        Colors.orange,
                        selectedPriority == 'Medium',
                        () {
                          setState(() {
                            selectedPriority = 'Medium';
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildPriorityChip(
                        'High',
                        Colors.red,
                        selectedPriority == 'High',
                        () {
                          setState(() {
                            selectedPriority = 'High';
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      // Submit report
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Report submitted successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      _messageController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E3C72),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Submit Report',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Previous Reports
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Reports',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, color: Colors.green),
                  ),
                  title: const Text('Payment Issue'),
                  subtitle: const Text('Resolved • 2 days ago'),
                  trailing: const Text('#BK001'),
                ),
                const Divider(),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.hourglass_empty,
                      color: Colors.orange,
                    ),
                  ),
                  title: const Text('Provider Issue'),
                  subtitle: const Text('In Progress • 5 days ago'),
                  trailing: const Text('#BK002'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // FIX 5: Updated priority chip with onTap callback
  Widget _buildPriorityChip(
    String label,
    Color color,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? color : Colors.grey[300]!),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? color : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  // Helper methods for launching URLs
  Future<void> _launchPhone(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  Future<void> _launchEmail(String email) async {
    final Uri launchUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }
}
