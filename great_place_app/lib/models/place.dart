import 'dart:io';
import 'package:flutter/foundation.dart';

class PlacesLocation {
  final double lattitude;
  final double longitude;
  final address;

  const PlacesLocation({
    @required this.lattitude,
    @required this.longitude,
    this.address,
  });
}

class Place {
  final String id;
  final String title;
  final File image;
  // final PlacesLocation location;

  Place({
    @required this.id,
    @required this.title,
    @required this.image,
    // @required this.location,
  });

  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    return <String, dynamic>{
      "id": id,
      "title": title,
      "image": image,
      "location": null,
    };
  }
}
