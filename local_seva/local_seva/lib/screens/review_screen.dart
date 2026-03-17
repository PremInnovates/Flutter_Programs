import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  final Map<String, dynamic>? bookingData; // Booking details for review

  const ReviewScreen({super.key, this.bookingData});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Rating variables
  int _overallRating = 0;
  int _serviceRating = 0;
  int _professionalismRating = 0;
  int _timelinessRating = 0;
  int _qualityRating = 0;

  // Review text
  final TextEditingController _reviewController = TextEditingController();

  // Photo attachments
  List<String> _attachedPhotos = [];

  // Anonymous review
  bool _isAnonymous = false;

  // Sample booking data
  late Map<String, dynamic> bookingDetails;

  // Sample reviews data
  final List<Map<String, dynamic>> allReviews = [
    {
      'id': 1,
      'userName': 'Rahul Sharma',
      'userImage': 'RS',
      'rating': 5,
      'date': '2 days ago',
      'service': 'AC Repair',
      'provider': 'Ramesh Patel',
      'review':
          'Excellent service! The technician was very professional and fixed my AC quickly. Highly recommended!',
      'likes': 24,
      'comments': 5,
      'photos': ['photo1', 'photo2'],
      'helpful': true,
    },
    {
      'id': 2,
      'userName': 'Priya Mehta',
      'userImage': 'PM',
      'rating': 4,
      'date': '5 days ago',
      'service': 'Plumbing',
      'provider': 'Suresh Yadav',
      'review':
          'Good work, but arrived a bit late. The quality of work was satisfactory.',
      'likes': 12,
      'comments': 3,
      'photos': [],
      'helpful': false,
    },
    {
      'id': 3,
      'userName': 'Amit Kumar',
      'userImage': 'AK',
      'rating': 5,
      'date': '1 week ago',
      'service': 'Cleaning',
      'provider': 'Priya Sharma',
      'review':
          'Amazing cleaning service! My house looks spotless. Will definitely book again.',
      'likes': 45,
      'comments': 8,
      'photos': ['photo1'],
      'helpful': true,
    },
    {
      'id': 4,
      'userName': 'Neha Singh',
      'userImage': 'NS',
      'rating': 3,
      'date': '2 weeks ago',
      'service': 'Electrical',
      'provider': 'Amit Kumar',
      'review':
          'Average service. The problem was fixed but took longer than expected.',
      'likes': 8,
      'comments': 2,
      'photos': [],
      'helpful': false,
    },
    {
      'id': 5,
      'userName': 'Vikram Rathod',
      'userImage': 'VR',
      'rating': 5,
      'date': '3 weeks ago',
      'service': 'Carpentry',
      'provider': 'Vikram Singh',
      'review':
          'Excellent carpenter! Made custom furniture exactly as I wanted. Great craftsmanship.',
      'likes': 67,
      'comments': 12,
      'photos': ['photo1', 'photo2', 'photo3'],
      'helpful': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Initialize booking details
    bookingDetails =
        widget.bookingData ??
        {
          'service': 'AC Repair',
          'provider': 'Ramesh Patel',
          'providerImage': 'RP',
          'date': '15 Mar 2026',
          'time': '10:00 AM',
          'amount': 499,
        };
  }

  @override
  void dispose() {
    _tabController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Reviews",
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
                  Icon(Icons.star, size: 20),
                  SizedBox(width: 4),
                  Text('Write'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.reviews, size: 20),
                  SizedBox(width: 4),
                  Text('My Reviews'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.rate_review, size: 20),
                  SizedBox(width: 4),
                  Text('All Reviews'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildWriteReviewTab(),
          _buildMyReviewsTab(),
          _buildAllReviewsTab(),
        ],
      ),
    );
  }

  // Write Review Tab
  Widget _buildWriteReviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Provider Info Card
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
                      bookingDetails['providerImage'] ??
                          bookingDetails['provider'][0],
                      style: const TextStyle(
                        fontSize: 24,
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
                        bookingDetails['provider'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        bookingDetails['service'],
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${bookingDetails['date']} • ${bookingDetails['time']}',
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Rating Card
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
                  'Rate Your Experience',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Overall Rating
                _buildRatingSection(
                  'Overall Experience',
                  _overallRating,
                  (rating) => setState(() => _overallRating = rating),
                ),

                const Divider(height: 30),

                // Detailed Ratings
                const Text(
                  'Detailed Ratings',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                _buildRatingRow('Service Quality', _serviceRating, (rating) {
                  setState(() => _serviceRating = rating);
                }),
                const SizedBox(height: 12),

                _buildRatingRow('Professionalism', _professionalismRating, (
                  rating,
                ) {
                  setState(() => _professionalismRating = rating);
                }),
                const SizedBox(height: 12),

                _buildRatingRow('Timeliness', _timelinessRating, (rating) {
                  setState(() => _timelinessRating = rating);
                }),
                const SizedBox(height: 12),

                _buildRatingRow('Work Quality', _qualityRating, (rating) {
                  setState(() => _qualityRating = rating);
                }),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Review Text
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
                  'Write Your Review',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _reviewController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText:
                        'Share your experience with this service provider...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Photo Attachment
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
                  'Add Photos',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...List.generate(_attachedPhotos.length, (index) {
                        return Container(
                          width: 80,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              const Center(
                                child: Icon(Icons.image, color: Colors.grey),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _attachedPhotos.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      GestureDetector(
                        onTap: () {
                          // Add photo
                          setState(() {
                            _attachedPhotos.add(
                              'photo${_attachedPhotos.length + 1}',
                            );
                          });
                        },
                        child: Container(
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF1E3C72).withOpacity(0.3),
                              style: BorderStyle.none,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate,
                                color: const Color(0xFF1E3C72).withOpacity(0.5),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Add',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: const Color(
                                    0xFF1E3C72,
                                  ).withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Anonymous Option
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
            child: Row(
              children: [
                Checkbox(
                  value: _isAnonymous,
                  onChanged: (value) {
                    setState(() {
                      _isAnonymous = value!;
                    });
                  },
                  activeColor: const Color(0xFF1E3C72),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Post as Anonymous',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Your name will not be displayed publicly',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: _overallRating > 0 ? _submitReview : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3C72),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Submit Review',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection(
    String title,
    int rating,
    Function(int) onRatingSelected,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => onRatingSelected(index + 1),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: index < rating ? Colors.amber : Colors.grey,
                  size: 36,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildRatingRow(
    String label,
    int rating,
    Function(int) onRatingSelected,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: TextStyle(color: Colors.grey[700])),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => onRatingSelected(index + 1),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: index < rating ? Colors.amber : Colors.grey,
                    size: 20,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  // My Reviews Tab
  Widget _buildMyReviewsTab() {
    // Sample user's reviews
    List<Map<String, dynamic>> myReviews = allReviews.sublist(0, 2);

    return myReviews.isEmpty
        ? _buildEmptyReviewsState()
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: myReviews.length,
            itemBuilder: (context, index) {
              return _buildReviewCard(myReviews[index], isMyReview: true);
            },
          );
  }

  // All Reviews Tab
  Widget _buildAllReviewsTab() {
    return Column(
      children: [
        // Summary Stats
        Container(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(Icons.star, '4.5', 'Average'),
              _buildStatItem(Icons.reviews, '156', 'Total Reviews'),
              _buildStatItem(Icons.thumb_up, '89%', 'Recommended'),
            ],
          ),
        ),

        // Reviews List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: allReviews.length,
            itemBuilder: (context, index) {
              return _buildReviewCard(allReviews[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF1E3C72), size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildReviewCard(
    Map<String, dynamic> review, {
    bool isMyReview = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3C72).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    review['userImage'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3C72),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['userName'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < review['rating']
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                        const SizedBox(width: 8),
                        Text(
                          review['date'],
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isMyReview)
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 18),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 18, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete'),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'delete') {
                      _showDeleteDialog();
                    }
                  },
                ),
            ],
          ),

          const SizedBox(height: 12),

          // Service & Provider
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF1E3C72).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${review['service']} • ${review['provider']}',
              style: TextStyle(fontSize: 12, color: const Color(0xFF1E3C72)),
            ),
          ),

          const SizedBox(height: 12),

          // Review Text
          Text(
            review['review'],
            style: TextStyle(color: Colors.grey[700], height: 1.4),
          ),

          // Photos
          if (review['photos'].isNotEmpty) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: review['photos'].length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 60,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(Icons.image, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ],

          const SizedBox(height: 12),

          // Actions
          Row(
            children: [
              IconButton(
                icon: Icon(
                  review['helpful'] ? Icons.thumb_up : Icons.thumb_up_outlined,
                  color: review['helpful']
                      ? const Color(0xFF1E3C72)
                      : Colors.grey,
                  size: 20,
                ),
                onPressed: () {},
              ),
              Text(
                '${review['likes']}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(
                  Icons.comment_outlined,
                  size: 20,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
              Text(
                '${review['comments']}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const Spacer(),
              TextButton(onPressed: () {}, child: const Text('Reply')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyReviewsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.rate_review_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No Reviews Yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your reviews will appear here',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _tabController.index = 0;
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3C72),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Write a Review'),
          ),
        ],
      ),
    );
  }

  void _submitReview() {
    // Submit review logic
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Thank You!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Your review has been submitted successfully',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _tabController.index = 1; // Go to My Reviews tab
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text('Delete Review'),
          content: const Text('Are you sure you want to delete this review?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Review deleted successfully'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
