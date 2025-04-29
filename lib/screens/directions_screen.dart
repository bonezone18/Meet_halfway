import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/place_model.dart';
import '../models/location_model.dart';
import '../providers/location_provider.dart';
import '../providers/directions_provider.dart';

class DirectionsScreen extends StatefulWidget {
  final Place place;

  const DirectionsScreen({super.key, required this.place});

  @override
  _DirectionsScreenState createState() => _DirectionsScreenState();
}

class _DirectionsScreenState extends State<DirectionsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedMode = 'driving';
  final List<String> _travelModes = ['driving', 'walking', 'bicycling', 'transit'];
  final Map<String, IconData> _modeIcons = {
    'driving': Icons.directions_car,
    'walking': Icons.directions_walk,
    'bicycling': Icons.directions_bike,
    'transit': Icons.directions_transit,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadDirections());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadDirections() async {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    final directionsProvider = Provider.of<DirectionsProvider>(context, listen: false);

    final locationA = locationProvider.locationA;
    final locationB = locationProvider.locationB;

    if (locationA != null && locationB != null) {
      final destination = Location(
        latitude: widget.place.latitude,
        longitude: widget.place.longitude,
        name: widget.place.name,
        address: widget.place.address,
      );

      await directionsProvider.getDirectionsFromA(locationA, destination, mode: _selectedMode);
      await directionsProvider.getDirectionsFromB(locationB, destination, mode: _selectedMode);
    }
  }

  void _openGoogleMapsUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch Google Maps')),
      );
    }
  }

  Widget _buildDirectionsTab(
    Map<String, dynamic>? directionsData,
    bool isLoading,
  ) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (directionsData == null) {
      return const Center(child: Text('No directions available'));
    }

    final distance = directionsData['distance'];
    final duration = directionsData['duration'];
    final steps = directionsData['steps'] as List;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Distance', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(distance['text'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Duration', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(duration['text'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Directions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: steps.length,
            itemBuilder: (context, index) {
              final step = steps[index];
              final htmlInstructions = step['html_instructions'] as String;
              final distance = step['distance']['text'];
              final duration = step['duration']['text'];
              final instructions = htmlInstructions.replaceAll(RegExp(r'<[^>]*>'), ' ').replaceAll('  ', ' ').trim();

              return Card(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(instructions),
                      const SizedBox(height: 4),
                      Text('$distance - $duration', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final directionsProvider = Provider.of<DirectionsProvider>(context);

    final locationA = locationProvider.locationA;
    final locationB = locationProvider.locationB;

    final destination = Location(
      latitude: widget.place.latitude,
      longitude: widget.place.longitude,
      name: widget.place.name,
      address: widget.place.address,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Directions to ${widget.place.name}'),
        backgroundColor: const Color(0xFF4285F4),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'From Your Location'),
            Tab(text: 'From Friend'),
          ],
        ),
      ),
      body: locationA == null || locationB == null
          ? const Center(child: Text('Location information is missing'))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _travelModes.map((mode) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ChoiceChip(
                          label: Icon(_modeIcons[mode]),
                          selected: _selectedMode == mode,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedMode = mode;
                              });
                              _loadDirections();
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                    directionsProvider.getStaticMapUrl(locationA!, locationB!, destination),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(child: Text('Map preview not available')),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildDirectionsTab(directionsProvider.directionsDataA, directionsProvider.isLoadingA),
                      _buildDirectionsTab(directionsProvider.directionsDataB, directionsProvider.isLoadingB),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final url = _tabController.index == 0
                          ? directionsProvider.getDirectionsUrlFromA(locationA, destination, mode: _selectedMode)
                          : directionsProvider.getDirectionsUrlFromB(locationB, destination, mode: _selectedMode);
                      _openGoogleMapsUrl(url);
                    },
                    icon: const Icon(Icons.map),
                    label: const Text('Open in Google Maps'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF34A853),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}