import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();

  bool _isLoading = false;
  bool _locationEnabled = false;
  String _currentAddress = "Fetching location...";
  Position? _currentPosition;

  int _selectedAddressType = 0;
  bool _isDefaultAddress = false;

  final List<Map<String, dynamic>> savedAddresses = [
    {
      'id': 1,
      'type': 'Home',
      'address': '123, Green Park Apartments, Andheri East, Mumbai - 400069',
      'landmark': 'Near Andheri Station',
      'icon': Icons.home,
      'color': Colors.blue,
      'isDefault': true,
    },
    {
      'id': 2,
      'type': 'Office',
      'address': '456, Business Hub, Bandra Kurla Complex, Mumbai - 400051',
      'landmark': 'Near BKC Signal',
      'icon': Icons.business,
      'color': Colors.orange,
      'isDefault': false,
    },
    {
      'id': 3,
      'type': 'Other',
      'address': '789, Park Avenue, Juhu, Mumbai - 400049',
      'landmark': 'Near Juhu Beach',
      'icon': Icons.location_on,
      'color': Colors.green,
      'isDefault': false,
    },
  ];

  final List<Map<String, dynamic>> recentLocations = [
    {
      'id': 1,
      'name': 'Mall',
      'address': 'Phoenix Marketcity, Kurla',
      'icon': Icons.shopping_bag,
    },
    {
      'id': 2,
      'name': 'Gym',
      'address': 'Cult Gym, Andheri West',
      'icon': Icons.fitness_center,
    },
    {
      'id': 3,
      'name': 'Restaurant',
      'address': 'Taj Mahal Tea House, Bandra',
      'icon': Icons.restaurant,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _checkLocationPermission();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _addressController.dispose();
    _landmarkController.dispose();
    super.dispose();
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _currentAddress = "Location services are disabled.";
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentAddress = "Location permissions are denied";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _currentAddress = "Location permissions are permanently denied";
      });
      return;
    }

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _locationEnabled = true;
        _currentAddress = "Getting address...";
      });

      // Here you would typically use a geocoding service to get address
      // For now, we'll just show coordinates
      setState(() {
        _currentAddress =
            "Lat: ${position.latitude}, Long: ${position.longitude}";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _currentAddress = "Failed to get location";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Location",
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
                  Icon(Icons.my_location, size: 20),
                  SizedBox(width: 4),
                  Text('Current'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark, size: 20),
                  SizedBox(width: 4),
                  Text('Saved'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_location, size: 20),
                  SizedBox(width: 4),
                  Text('Add New'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCurrentLocationTab(),
          _buildSavedAddressesTab(),
          _buildAddAddressTab(),
        ],
      ),
    );
  }

  // Current Location Tab
  Widget _buildCurrentLocationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Map Placeholder (in real app, use Google Maps)
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://via.placeholder.com/400x250/1E3C72/FFFFFF?text=Map+View',
                ),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.my_location,
                      color: Color(0xFF1E3C72),
                      size: 30,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: FloatingActionButton.small(
                    onPressed: _getCurrentLocation,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.refresh, color: Color(0xFF1E3C72)),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Current Location Card
          Container(
            padding: const EdgeInsets.all(20),
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
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3C72).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF1E3C72),
                                ),
                              ),
                            )
                          : Icon(
                              _locationEnabled
                                  ? Icons.location_on
                                  : Icons.location_off,
                              color: _locationEnabled
                                  ? Colors.green
                                  : Colors.red,
                              size: 24,
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _locationEnabled
                                ? 'Current Location'
                                : 'Location Disabled',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _currentAddress,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                if (!_locationEnabled) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _checkLocationPermission,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3C72),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Enable Location'),
                    ),
                  ),
                ],

                if (_locationEnabled) ...[
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  // Use Current Location Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Use current location
                        Navigator.pop(context, _currentAddress);
                      },
                      icon: const Icon(Icons.check),
                      label: const Text('Use Current Location'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3C72),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Recent Locations
          Container(
            padding: const EdgeInsets.all(20),
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
                const Text(
                  'Recent Locations',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ...List.generate(recentLocations.length, (index) {
                  final location = recentLocations[index];
                  return ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3C72).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        location['icon'],
                        color: const Color(0xFF1E3C72),
                      ),
                    ),
                    title: Text(location['name']),
                    subtitle: Text(
                      location['address'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    onTap: () {
                      Navigator.pop(context, location['address']);
                    },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Saved Addresses Tab
  Widget _buildSavedAddressesTab() {
    return Column(
      children: [
        // Search Bar
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search saved addresses...",
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

        // Address List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: savedAddresses.length,
            itemBuilder: (context, index) {
              final address = savedAddresses[index];
              return _buildAddressCard(address);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAddressCard(Map<String, dynamic> address) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Stack(
        children: [
          if (address['isDefault'])
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Default',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: address['color'].withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(address['icon'], color: address['color'], size: 24),
            ),
            title: Row(
              children: [
                Text(
                  address['type'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  address['address'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                if (address['landmark'] != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Landmark: ${address['landmark']}',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  onPressed: () {
                    _editAddress(address);
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _deleteAddress(address['id']);
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context, address['address']);
            },
          ),
        ],
      ),
    );
  }

  // Add New Address Tab
  Widget _buildAddAddressTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Map Preview
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://via.placeholder.com/400x180/1E3C72/FFFFFF?text=Select+on+Map',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add_location,
                  color: Color(0xFF1E3C72),
                  size: 30,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Address Form
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
                  'Add New Address',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Address Type
                const Text(
                  'Address Type',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildAddressTypeChip('Home', Icons.home, 0, Colors.blue),
                    const SizedBox(width: 8),
                    _buildAddressTypeChip(
                      'Office',
                      Icons.business,
                      1,
                      Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    _buildAddressTypeChip(
                      'Other',
                      Icons.location_on,
                      2,
                      Colors.green,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Address Fields
                TextField(
                  controller: _addressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Complete Address *',
                    hintText: 'House/Flat No., Building, Street, Area',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: _landmarkController,
                  decoration: InputDecoration(
                    labelText: 'Landmark (Optional)',
                    hintText: 'Nearby landmark',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Set as Default
                Row(
                  children: [
                    Checkbox(
                      value: _isDefaultAddress,
                      onChanged: (value) {
                        setState(() {
                          _isDefaultAddress = value!;
                        });
                      },
                      activeColor: const Color(0xFF1E3C72),
                    ),
                    const Text('Set as default address'),
                  ],
                ),

                const SizedBox(height: 20),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _addressController.text.isEmpty
                        ? null
                        : _saveNewAddress,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E3C72),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Save Address',
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
        ],
      ),
    );
  }

  Widget _buildAddressTypeChip(
    String label,
    IconData icon,
    int index,
    Color color,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedAddressType = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: _selectedAddressType == index
                ? color.withOpacity(0.2)
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _selectedAddressType == index ? color : Colors.grey[300]!,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: _selectedAddressType == index ? color : Colors.grey[600],
                size: 18,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: _selectedAddressType == index
                      ? color
                      : Colors.grey[600],
                  fontWeight: _selectedAddressType == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editAddress(Map<String, dynamic> address) {
    _tabController.index = 2;
    _addressController.text = address['address'];
    _landmarkController.text = address['landmark'] ?? '';

    int typeIndex = address['type'] == 'Home'
        ? 0
        : address['type'] == 'Office'
        ? 1
        : 2;
    setState(() {
      _selectedAddressType = typeIndex;
    });
  }

  void _deleteAddress(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text('Delete Address'),
          content: const Text('Are you sure you want to delete this address?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Delete address logic
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Address deleted successfully'),
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

  void _saveNewAddress() {
    // Save address logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Address saved successfully'),
        backgroundColor: Colors.green,
      ),
    );

    // Clear form
    _addressController.clear();
    _landmarkController.clear();
    setState(() {
      _selectedAddressType = 0;
      _isDefaultAddress = false;
    });

    // Switch to saved addresses tab
    _tabController.index = 1;
  }
}
