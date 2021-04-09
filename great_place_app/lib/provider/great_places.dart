import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:great_place_app/helpers/db_helper.dart';
import 'package:great_place_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  DBHelper dbHelper = DBHelper();

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    // PlacesLocation pickedLocation,
    // ) async {
    // final address = await LocationHelper.getPlaceAddress(
    //   pickedLocation.lattitude,
    //   pickedLocation.longitude,
    // );
    // final updatedLocation = PlacesLocation(
    //   lattitude: pickedLocation.lattitude,
    //   longitude: pickedLocation.longitude,
    //   address: address,
    // );
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      //location: updatedLocation,
    );

    _items.add(newPlace);
    notifyListeners();

    DBHelper.insertData('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      // 'loc_lat': newPlace.location.lattitude,
      //  'loc_lng': newPlace.location.longitude,
      //  'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    List<Map<String, dynamic>> dataList = await DBHelper.getData('user_places');

    _items = dataList
        .map(
          (fetchItem) => Place(
            id: fetchItem['id'],
            title: fetchItem['title'],
            image: File(fetchItem['image']),
            // location: PlacesLocation(
            //     lattitude: fetchItem['loc_lat'],
            //     longitude: fetchItem['loc_lng'],
            //     address: fetchItem['address']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
