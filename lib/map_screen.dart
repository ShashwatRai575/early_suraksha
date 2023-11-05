import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class MapSample extends StatefulWidget {
  Position? position;

  MapSample(this.position);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

    CameraPosition? _kGooglePlex;

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _kGooglePlex = CameraPosition(
    target: LatLng(widget.position!.latitude, widget.position!.longitude),
    zoom: 14.4746,
  );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  GoogleMap(
          markers: {
            Marker(markerId: MarkerId("current"),
             icon : BitmapDescriptor.defaultMarker,
         position: LatLng(widget.position!.latitude, widget.position!.longitude),)
          },
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex!,
          onMapCreated: (GoogleMapController controller) {
            //_controller.complete(controller);
          },
        ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}