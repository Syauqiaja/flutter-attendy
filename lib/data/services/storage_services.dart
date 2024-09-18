import 'dart:convert';
import 'dart:ffi';

import 'package:attendy_flutter/core/utils/keys.dart';
import 'package:attendy_flutter/data/models/place.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StorageService extends GetxService {
  late GetStorage _box;
  Future<StorageService> init() async {
    _box = GetStorage();
    _box.listen(() => print("StorageService: GetStorage changed"));
    _box.listenKey(attendanceKey, (val) => print("Changes: $val"));

    Place firstPlace = const Place(
      latLng: LatLng(10, -100),
      id: 1,
      title: "Michigan Auss",
      fullAddress: "It is the full address",
      checkInTime: "08:00 AM",
      checkOutTime: "05:00 PM",
    );

    await _box.writeIfNull(attendanceKey, []);
    await _box.writeIfNull(placeKey, jsonEncode([firstPlace]));
    await _box.writeIfNull(selectedPlace, jsonEncode([firstPlace]));
    return this;
  }

  T read<T>(String key) {
    return _box.read(key);
  }

  void write(String key, dynamic value) async {
    await _box.write(key, value);
  }
}
