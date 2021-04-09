import 'package:flutter/material.dart';
import 'package:great_place_app/helpers/location_helper.dart';
import 'package:great_place_app/screens/dynamic_map/map_screen.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String previewUrl;

  // void _showPreview(double lat, double lng) {

  // }

  Future<void> getCurrentLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.genereteLocationPreviewImage(
        latitude: locData.latitude, longitude: locData.longitude);

    setState(() {
      previewUrl = staticMapImageUrl;
    });
    // _showPreview(locData.latitude, locData.longitude);
    widget.onSelectPlace(locData.latitude, locData.longitude);
  }

  Future<void> selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: previewUrl == null
              ? Center(
                  child: Text(
                    "No Location Selected",
                    textAlign: TextAlign.center,
                  ),
                )
              : Image.network(
                  previewUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(
                onPressed: getCurrentLocation,
                icon: Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                ),
                label: Text(
                  "Current Location",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
            FlatButton.icon(
                onPressed: selectOnMap,
                icon: Icon(
                  Icons.map,
                  color: Theme.of(context).primaryColor,
                ),
                label: Text(
                  "Select On Map",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ))
          ],
        )
      ],
    );
  }
}
