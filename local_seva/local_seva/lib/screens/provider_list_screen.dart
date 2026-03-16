import 'package:flutter/material.dart';
import 'provider_profile_screen.dart';

class ProviderListScreen extends StatefulWidget {
  final String? category; // Optional category filter

  const ProviderListScreen({super.key, this.category});

  @override
  State<ProviderListScreen> createState() => _ProviderListScreenState();
}

class _ProviderListScreenState extends State<ProviderListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _selectedSort = 'Rating';
  bool _isGridView = false;
  
  final List<Map<String, dynamic>> providers = [
    {
      "name": "Ramesh Patel",
      "price": "299",
      "rating": 4.8,
      "reviews": 245,
      "experience": "8 years",
      "jobs": 1240,
      "image": "https://via.placeholder.com/150",
      "category": "Plumber",
      "available": true,
      "verified": true,
      "distance": "2.5 km",
      "specialty": "Pipe Fitting Expert",
      "completion": "98%",
    },
    {
      "name": "Kunal Mehta",
      "price": "279",
      "rating": 4.9,
      "reviews": 189,
      "experience": "5 years",
      "jobs": 980,
      "image": "https://via.placeholder.com/150",
      "category": "Electrician",
      "available": true,
      "verified": true,
      "distance": "1.8 km",
      "specialty": "Wiring Specialist",
      "completion": "99%",
    },
    {
      "name": "Suresh Yadav",
      "price": "349",
      "rating": 4.7,
      "reviews": 312,
      "experience": "10 years",
      "jobs": 2150,
      "image": "https://via.placeholder.com/150",
      "category": "AC Repair",
      "available": false,
      "verified": true,
      "distance": "3.2 km",
      "specialty": "All AC Brands",
      "completion": "96%",
    },
    {
      "name": "Priya Sharma",
      "price": "399",
      "rating": 5.0,
      "reviews": 156,
      "experience": "4 years",
      "jobs": 567,
      "image": "https://via.placeholder.com/150",
      "category": "Cleaning",
      "available": true,
      "verified": true,
      "distance": "1.2 km",
      "specialty": "Deep Cleaning",
      "completion": "100%",
    },
    {
      "name": "Amit Kumar",
      "price": "259",
      "rating": 4.6,
      "reviews": 98,
      "experience": "3 years",
      "jobs": 445,
      "image": "https://via.placeholder.com/150",
      "category": "Carpenter",
      "available": true,
      "verified": false,
      "distance": "4.0 km",
      "specialty": "Furniture Repair",
      "completion": "95%",
    },
    {
      "name": "Vikram Singh",
      "price": "319",
      "rating": 4.8,
      "reviews": 203,
      "experience": "7 years",
      "jobs": 1520,
      "image": "https://via.placeholder.com/150",
      "category": "Painting",
      "available": true,
      "verified": true,
      "distance": "2.1 km",
      "specialty": "Wall Painting",
      "completion": "97%",
    },
  ];

  List<Map<String, dynamic>> filteredProviders = [];
  List<String> categories = ['All', 'Plumber', 'Electrician', 'AC Repair', 'Cleaning', 'Carpenter', 'Painting'];
  String selectedCategory = 'All';
  RangeValues _priceRange = const RangeValues(200, 500);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Set initial category if provided
    if (widget.category != null && categories.contains(widget.category)) {
      selectedCategory = widget.category!;
    }
    
    filterProviders();
  }

  void filterProviders() {
    setState(() {
      filteredProviders = providers.where((provider) {
        // Category filter
        if (selectedCategory != 'All' && provider['category'] != selectedCategory) {
          return false;
        }
        
        // Price range filter
        double price = double.parse(provider['price']);
        if (price < _priceRange.start || price > _priceRange.end) {
          return false;
        }
        
        // Search filter
        if (_searchController.text.isNotEmpty) {
          return provider['name'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
                 provider['specialty'].toLowerCase().contains(_searchController.text.toLowerCase());
        }
        
        return true;
      }).toList();
      
      // Sort providers
      sortProviders();
    });
  }

  void sortProviders() {
    switch (_selectedSort) {
      case 'Rating':
        filteredProviders.sort((a, b) => b['rating'].compareTo(a['rating']));
        break;
      case 'Price: Low to High':
        filteredProviders.sort((a, b) => double.parse(a['price']).compareTo(double.parse(b['price'])));
        break;
      case 'Price: High to Low':
        filteredProviders.sort((a, b) => double.parse(b['price']).compareTo(double.parse(a['price'])));
        break;
      case 'Experience':
        filteredProviders.sort((a, b) => int.parse(b['experience'].split(' ')[0]).compareTo(int.parse(a['experience'].split(' ')[0])));
        break;
      case 'Distance':
        filteredProviders.sort((a, b) => double.parse(a['distance'].split(' ')[0]).compareTo(double.parse(b['distance'].split(' ')[0])));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          widget.category ?? "Service Providers",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF1E3C72),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => filterProviders(),
                    decoration: InputDecoration(
                      hintText: "Search by name or specialty...",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF1E3C72)),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: () {
                                _searchController.clear();
                                filterProviders();
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
              
              // Category Chips
              Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(categories[index]),
                        selected: selectedCategory == categories[index],
                        onSelected: (selected) {
                          setState(() {
                            selectedCategory = categories[index];
                            filterProviders();
                          });
                        },
                        backgroundColor: Colors.white,
                        selectedColor: const Color(0xFF1E3C72),
                        labelStyle: TextStyle(
                          color: selectedCategory == categories[index] 
                              ? Colors.white 
                              : Colors.black87,
                          fontWeight: selectedCategory == categories[index]
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        checkmarkColor: Colors.white,
                        elevation: 2,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Sort and Count Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredProviders.length} providers found",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      "Sort by: ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    DropdownButton<String>(
                      value: _selectedSort,
                      items: const [
                        DropdownMenuItem(value: 'Rating', child: Text('Rating')),
                        DropdownMenuItem(value: 'Price: Low to High', child: Text('Price: Low to High')),
                        DropdownMenuItem(value: 'Price: High to Low', child: Text('Price: High to Low')),
                        DropdownMenuItem(value: 'Experience', child: Text('Experience')),
                        DropdownMenuItem(value: 'Distance', child: Text('Distance')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedSort = value!;
                          sortProviders();
                        });
                      },
                      underline: Container(),
                      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF1E3C72)),
                      style: const TextStyle(
                        color: Color(0xFF1E3C72),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Provider List/Grid
          Expanded(
            child: filteredProviders.isEmpty
                ? _buildEmptyState()
                : (_isGridView ? _buildGridView() : _buildListView()),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredProviders.length,
      itemBuilder: (context, index) {
        final provider = filteredProviders[index];
        return _buildProviderCard(provider, index);
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: filteredProviders.length,
      itemBuilder: (context, index) {
        final provider = filteredProviders[index];
        return _buildProviderGridCard(provider, index);
      },
    );
  }

  Widget _buildProviderCard(Map<String, dynamic> provider, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProviderProfileScreen(provider: provider),
          ),
        );
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section with image and availability
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    color: const Color(0xFF1E3C72).withOpacity(0.1),
                    child: Center(
                      child: Text(
                        provider['name'][0],
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3C72),
                        ),
                      ),
                    ),
                  ),
                ),
                if (provider['verified'])
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                if (!provider['available'])
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Busy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          provider['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 14),
                            const SizedBox(width: 2),
                            Text(
                              provider['rating'].toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 4),
                  
                  Text(
                    provider['specialty'],
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Stats Row
                  Row(
                    children: [
                      _buildStatItem(Icons.work_outline, provider['experience']),
                      const SizedBox(width: 12),
                      _buildStatItem(Icons.location_on_outlined, provider['distance']),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Price and Action Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "₹${provider['price']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xFF1E3C72),
                            ),
                          ),
                          Text(
                            "starting price",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: provider['available'] 
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProviderProfileScreen(provider: provider),
                                  ),
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E3C72),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(80, 36),
                        ),
                        child: const Text(
                          'Book',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderGridCard(Map<String, dynamic> provider, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProviderProfileScreen(provider: provider),
          ),
        );
      },
      child: Container(
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
            // Image
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1E3C72).withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Text(
                  provider['name'][0],
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3C72),
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          provider['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (provider['verified'])
                        const Icon(Icons.verified, color: Colors.green, size: 14),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 12),
                      const SizedBox(width: 2),
                      Text(
                        provider['rating'].toString(),
                        style: const TextStyle(fontSize: 11),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${provider['reviews']})',
                        style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₹${provider['price']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF1E3C72),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[500]),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No providers found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                selectedCategory = 'All';
                _priceRange = const RangeValues(200, 500);
                _searchController.clear();
                filterProviders();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3C72),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Clear Filters'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
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
                  
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Filter Providers',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  const Divider(),
                  
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        const Text(
                          'Price Range',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        RangeSlider(
                          values: _priceRange,
                          min: 0,
                          max: 1000,
                          divisions: 20,
                          labels: RangeLabels(
                            '₹${_priceRange.start.round()}',
                            '₹${_priceRange.end.round()}',
                          ),
                          onChanged: (values) {
                            setModalState(() {
                              _priceRange = values;
                            });
                          },
                          activeColor: const Color(0xFF1E3C72),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('₹${_priceRange.start.round()}'),
                            Text('₹${_priceRange.end.round()}'),
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        
                        const Text(
                          'Availability',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          children: [
                            FilterChip(
                              label: const Text('Available Now'),
                              selected: true,
                              onSelected: (value) {},
                            ),
                            FilterChip(
                              label: const Text('Verified Only'),
                              selected: false,
                              onSelected: (value) {},
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        
                        const Text(
                          'Rating',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          children: [
                            FilterChip(
                              label: const Text('4.5+'),
                              selected: false,
                              onSelected: (value) {},
                            ),
                            FilterChip(
                              label: const Text('4.0+'),
                              selected: true,
                              onSelected: (value) {},
                            ),
                            FilterChip(
                              label: const Text('3.5+'),
                              selected: false,
                              onSelected: (value) {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF1E3C72)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Color(0xFF1E3C72)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              filterProviders();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E3C72),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: const Text('Apply'),
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

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}