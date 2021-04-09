import 'package:flutter/material.dart';
import 'package:great_place_app/provider/great_places.dart';
import 'package:great_place_app/screens/add_place/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlaceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: [
          GestureDetector(
            child: Icon(Icons.add),
            onTap: () {
              Navigator.pushNamed(context, AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<GreatPlaces>(
                    child: Center(
                      child: Text("Got no places yet!"),
                    ),
                    builder: (context, greatPlaces, child) =>
                        greatPlaces.items.length <= 0
                            ? child
                            : ListView.builder(
                                itemCount: greatPlaces.items.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: FileImage(
                                          greatPlaces.items[index].image),
                                    ),
                                    title: Text(greatPlaces.items[index].title),
                                    // subtitle: Text(
                                    //     greatPlaces.items[index].location.address),
                                    onTap: () {},
                                  );
                                },
                              )),
      ),
    );
  }
}
