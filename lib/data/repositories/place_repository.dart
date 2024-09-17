
import 'package:attendy_flutter/data/models/place.dart';
import 'package:attendy_flutter/data/providers/storage_provider.dart';

class PlaceRepository {
  StorageProvider storageProvider;
  PlaceRepository({required this.storageProvider});

  List<Place> readPlaces() => storageProvider.readPlaces();
  void addPlace(Place place){
    List<Place> places = readPlaces();
    places.add(place);
    storageProvider.writePlaces(places);
  }

  List<Place> readSelectedPlace() => storageProvider.readSelectedPlace();
  selectPlace(Place place) => storageProvider.selectPlace(place);
}
