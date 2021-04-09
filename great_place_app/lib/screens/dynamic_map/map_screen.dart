import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_place_app/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlacesLocation initialLocation;
  final bool isSelecting;

  const MapScreen(
      {Key key,
      this.initialLocation =
          const PlacesLocation(lattitude: 23.777, longitude: 90.399),
      this.isSelecting = false})
      : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectingLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Map"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (widget.isSelecting) {
                Navigator.of(context).pop(_pickedLocation);
              }
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.initialLocation.lattitude,
                widget.initialLocation.longitude),
            zoom: 16),
        onTap: widget.isSelecting ? _selectingLocation : null,
        markers: _pickedLocation == null
            ? null
            : {
                Marker(markerId: MarkerId("m1"), position: _pickedLocation),
              },
      ),
    );
  }
}
