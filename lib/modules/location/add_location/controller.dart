import 'package:attendy_flutter/data/models/place.dart';
import 'package:attendy_flutter/data/repositories/place_repository.dart';
import 'package:attendy_flutter/modules/fill_attendance/widgets/failed_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddLocationController extends GetxController {
  PlaceRepository placeRepository;
  AddLocationController({required this.placeRepository});

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final fullAddressController = TextEditingController();
  final checkInController = TextEditingController();
  final checkOutController = TextEditingController();
  final RxSet<Marker> markers = <Marker>{}.obs;
  late GoogleMapController mapController;

  void onMapReady(GoogleMapController mapController) {
    this.mapController = mapController;
  }

  bool addLocation() {
    if(markers.isEmpty){
      return false;
    }
    int lastIndex = placeRepository.readPlaces().last.id;
    Place place = Place(
      latLng: markers.first.position,
      id: lastIndex + 1,
      title: titleController.text,
      fullAddress: fullAddressController.text,
      checkInTime: checkInController.text,
      checkOutTime: checkOutController.text,
    );
    placeRepository.addPlace(place);
    return true;
  }

  void addMarker(LatLng latLng) {
    markers.assign(Marker(markerId: MarkerId("NewPlace"), position: latLng));
  }
}
