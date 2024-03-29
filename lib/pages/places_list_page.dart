import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: Center(child: Text('No registered location')),
                builder: (context, greatPlaces, child) =>
                    greatPlaces.itemsCount == 0
                        ? child ?? Center(child: Text('Error'))
                        : ListView.builder(
                            itemCount: greatPlaces.itemsCount,
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                  greatPlaces.itemByIndex(index).image!,
                                ),
                              ),
                              title: Text(greatPlaces.itemByIndex(index).title),
                              subtitle: Text(greatPlaces
                                  .itemByIndex(index)
                                  .location!
                                  .address!),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.PLACE_DETAIL,
                                  arguments: greatPlaces.itemByIndex(index),
                                );
                              },
                            ),
                          ),
              ),
      ),
    );
  }
}
