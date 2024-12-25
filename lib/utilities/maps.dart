import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:kriv/utilities/responsive.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static LatLng _defaultLocation = const LatLng(28.6139, 77.2090); // Default: Delhi
  Marker? _currentMarker;
  LatLng? _currentLocation;
  String _address = "No location selected";
  final TextEditingController _pinCodeController = TextEditingController();
  final Completer<GoogleMapController> _mapController = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location"),
         automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter Pin Code:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _pinCodeController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter Pin Code",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _locateByPinCode,
                      child: const Text("Go"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _defaultLocation, zoom: 10),
              onMapCreated: (controller) => _mapController.complete(controller),
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
          InkWell(
            onTap: () {
                  Navigator.pop(
                      context, _currentLocation != null ? _address : null);
                },
            child: Container(
              color:const Color.fromRGBO(107, 67, 151, 1),
              width: Responsive.width(100, context),
                padding:const EdgeInsets.all(16.0) ,
                child: Center(child:  Text("Confirm",style: TextStyle(fontSize:Responsive.height(2.1, context) , fontWeight: FontWeight.w600,fontFamily: 'Poppins',color: Colors.white),))),
          )
        ],
      ),
    );
  }

  /// Handle tap on the map to set the marker and fetch the address
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

  /// Fetch location from the entered pin code and move the map
  Future<void> _locateByPinCode() async {
    String pinCode = _pinCodeController.text.trim();
    if (pinCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid pin code")),
      );
      return;
    }

    setState(() {
      _address = "Fetching location for pin code...";
    });

    try {
      List<Location> locations = await locationFromAddress(pinCode);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        LatLng newLocation = LatLng(location.latitude, location.longitude);
        List<Placemark> placemarks = await placemarkFromCoordinates(
          location.latitude,
          location.longitude,
        );
        
        setState(() {
          _currentLocation = newLocation;
          _currentMarker = Marker(
            markerId: const MarkerId('pinCodeLocation'),
            position: newLocation,
            infoWindow: InfoWindow(
              title: 'Pin Code Location',
              snippet: '${location.latitude}, ${location.longitude}',
            ),
          );
          if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          setState(() {
            _address =
                "${place.name}, ${place.subLocality}, ${place.locality}, ${place.postalCode}";
          });
        }
          // _address = "Location found for pin code: $pinCode";
          
        });

        // Move the map to the new location
        final GoogleMapController controller = await _mapController.future;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: newLocation, zoom: 14),
          ),
        );
      } else {
        setState(() {
          _address = "No location found for the entered pin code.";
        });
      }
    } catch (e) {
      setState(() {
        _address = "Error fetching location: $e";
      });
    }
  }
}
