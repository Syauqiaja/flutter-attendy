import 'package:attendy_flutter/core/utils/keys.dart';
import 'package:attendy_flutter/data/models/attendance.dart';
import 'package:attendy_flutter/data/models/place.dart';
import 'package:attendy_flutter/data/repositories/attendance_repository.dart';
import 'package:attendy_flutter/data/repositories/place_repository.dart';
import 'package:attendy_flutter/data/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  HomeController({
    required this.userRepository,
    required this.attendanceRepository,
    required this.placeRepository,
  });
  UserRepository userRepository;
  AttendanceRepository attendanceRepository;
  PlaceRepository placeRepository;
  final Rx<User?> user = (null as User?).obs;
  final Rx<Place?> place = (null as Place?).obs;
  final RxList<Place> places = RxList.empty();
  final RxList<Attendance> attendances = RxList.empty();
  final totalDays = 0.obs;
  final present = 0.obs;
  final absent = 0.obs;
  final performance = 0.obs;

  signOut() {
    userRepository.signOut();
  }

  @override
  void onInit() {
    attendances.listen((lists) {
      if (lists.isNotEmpty) {
        //Find latest
        Attendance firstAtt = lists.first;
        attendances.forEach((item) {
          if (firstAtt.checkInTime.isAfter(item.checkInTime)) {
            firstAtt = item;
          }
        });

        totalDays.value =
            DateTime.now().difference(firstAtt.checkInTime).inDays + 1;
        List<Attendance> distinctList = lists
            .map(
              (element) => Attendance(
                userId: "",
                placeId: 0,
                checkInTime: DateTime(
                  element.checkInTime.year,
                  element.checkInTime.month,
                  element.checkInTime.day,
                ),
              ),
            )
            .toSet()
            .toList();
        present.value = distinctList.length;
        absent.value = totalDays.value - present.value;
        if (totalDays > 0) {
          performance.value =
              ((present.value.toDouble() / totalDays.value.toDouble()) * 100)
                  .round();
        } else {
          performance.value = 0;
        }
      }
    });

    user.value = userRepository.getUser();
    attendances.value =
        attendanceRepository.readUserAttendances(userRepository.getUser().uid).reversed.toList();
    place.value = placeRepository.readSelectedPlace()[0];
    places.value = placeRepository.readPlaces();
    print(places.map((f) => f.title));

    GetStorage().listenKey(attendanceKey, (value) {
      attendances.value =
          attendanceRepository.readUserAttendances(userRepository.getUser().uid).reversed.toList();
    });
    GetStorage().listenKey(placeKey, (value) {
      places.value = placeRepository.readPlaces();
    });
    super.onInit();
  }

  selectPlace(Place place) {
    placeRepository.selectPlace(place);
    this.place.value = placeRepository.readSelectedPlace()[0];
  }
}
