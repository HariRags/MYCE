import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static LatLng _pDelhi = LatLng(28.6139, 77.2090);
  Marker? _currentMarker;
  LatLng? _currentLocation;
  String _address = "No location selected";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, _currentLocation != null ? _address : null);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: _pDelhi, zoom: 10),
              onTap: _onMapTapped,
              markers: _currentMarker != null ? {_currentMarker!} : {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _address,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _onMapTapped(LatLng tappedLocation) async {
    setState(() {
      _currentMarker = Marker(
        markerId: const MarkerId('selectedLocation'),
        position: tappedLocation,
        infoWindow: InfoWindow(
          title: 'Selected Location',
          snippet: '${tappedLocation.latitude}, ${tappedLocation.longitude}',
        ),
      );
      _currentLocation = tappedLocation;
      _address = "Fetching address...";
    });

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        tappedLocation.latitude,
        tappedLocation.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        print(place);
        setState(() {
          _address =
              "${place.name}, ${place.subLocality}, ${place.locality}, ${place.postalCode}";
        });
      } else {
        setState(() {
          _address = "No address found.";
        });
      }
    } catch (e) {
      setState(() {
        _address = "Error fetching address: $e";
      });
    }
  }
}
