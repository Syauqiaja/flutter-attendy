import 'dart:convert';
import 'package:attendy_flutter/core/utils/keys.dart';
import 'package:attendy_flutter/data/models/attendance.dart';
import 'package:attendy_flutter/data/models/place.dart';
import 'package:attendy_flutter/data/services/storage_services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StorageProvider {
  StorageService storageService = Get.find<StorageService>();

  List<Attendance> readAttendances() {
    var attendances = <Attendance>[];
    jsonDecode(storageService.read(attendanceKey).toString())
        .forEach((e) => attendances.add(Attendance.fromJson(e)));
    return attendances;
  }

  List<Attendance> readUserAttendances(String uid) {
    var attendances = <Attendance>[];
    jsonDecode(storageService.read(attendanceKey).toString())
        .forEach((e) => attendances.add(Attendance.fromJson(e)));
    attendances.removeWhere((test)=>test.userId != uid);
    return attendances;
  }

  writeAttendances(List<Attendance> attendances) {
    storageService.write(attendanceKey, jsonEncode(attendances));
  }

  //Not enough time, hardcode saja maaf
  List<Place> readPlaces() {
    var places = <Place>[];
    jsonDecode(storageService.read(placeKey).toString())
        .forEach((e) => places.add(Place.fromJson(e)));
    return places;
  }
  List<Place> readSelectedPlace() {
    var places = <Place>[];
    jsonDecode(storageService.read(selectedPlace).toString())
        .forEach((e) => places.add(Place.fromJson(e)));
    if(places.isEmpty){
      places.add(readPlaces()[0]);
    }
    return places;
  }
  selectPlace(Place place){
    storageService.write(selectedPlace, jsonEncode([place]));
  }

  writePlaces(List<Place> places) {
    storageService.write(placeKey, jsonEncode(places));
  }
}
