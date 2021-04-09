import 'package:flutter/material.dart';
import 'package:great_place_app/provider/great_places.dart';
import 'package:great_place_app/screens/add_place/add_place_screen.dart';
import 'package:great_place_app/screens/places_list/place_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
        },
        home: PlaceListScreen(),
      ),
    );
  }
}
