import 'package:early_suraksha/global.dart';
import 'package:early_suraksha/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:audioplayers/audioplayers.dart';

class HomePage extends StatefulWidget {
  final String authToken;

  HomePage(this.authToken);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? _currentLocation;
  String _currentAddress = "";

  Future<Position> _getCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }
  

  Future<String> _getAddressFromCoordinates() async {
    final List<Placemark> placemarks = await placemarkFromCoordinates(
      _currentLocation!.latitude,
      _currentLocation!.longitude,
    );
    final Placemark place = placemarks[0];

    return "${place.locality}, ${place.country}";
  }

  Future<void> sendLocationData() async {
    try {
      // Get the current location
      _currentLocation = await _getCurrentLocation();

      // Prepare the data to be sent in the request body
      Map<String, dynamic> requestData = {
        "long": _currentLocation?.longitude,
        "lat": _currentLocation?.latitude,
      };

      // Define the API endpoint URL
      String apiUrl =
          'https://monkfish-app-umzoc.ondigitalocean.app/api/user/setLocation';

      // Send a POST request to the API with the authToken in the header
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'auth-token': '${widget.authToken}',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        // Request was successful
        // You can handle the response here
        print('Response data: ${response.body}');
      } else {
        // Request failed
        print('Failed to send data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors that may occur during the process
      print('Error: $e');
    }
  }

    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Stack(children: <Widget>[
        MapSample(pos),

        Positioned(
          top: MediaQuery.of(context).size.height * 0.4,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.warning,
                            size: 24,
                            color: Colors.yellow,
                          ),
                          Text(
                            'Alert! Lightning',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Location Coordinates",
                      style: TextStyle(fontSize: 28),
                    ),
                    Text(
                      "Latitude=${pos?.latitude}; Longitude= ${pos?.longitude}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Location Address",
                      style: TextStyle(fontSize: 28),
                    ),
                    Text(_currentAddress),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        sendLocationData();
                        _currentLocation = await _getCurrentLocation();
                        final String address =
                            await _getAddressFromCoordinates();
                        setState(() {
                          _currentAddress = address;
                        });

                        // Use widget.authToken to make authenticated API requests or perform other actions.
                        // Implement your home screen UI and functionality here.
                      },
                      child: const Text(
                        'Get Address',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        _currentLocation = await _getCurrentLocation();
                        final String address =
                            await _getAddressFromCoordinates();
                        setState(() {
                          _currentAddress = address;
                        });
                      },
                      child: const Text(
                        'Update Location',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    TextButton(
            onPressed: (){},
            child: Text('Play Audio'),
          ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // MapSample(_currentLocation)
      ]),
    );
  }
}
