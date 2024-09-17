import 'package:attendy_flutter/core/utils/extensions.dart';
import 'package:attendy_flutter/core/values/colors.dart';
import 'package:attendy_flutter/data/models/attendance.dart';
import 'package:attendy_flutter/data/models/place.dart';
import 'package:attendy_flutter/data/repositories/attendance_repository.dart';
import 'package:attendy_flutter/data/repositories/place_repository.dart';
import 'package:attendy_flutter/data/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' hide PermissionStatus;
import 'package:permission_handler/permission_handler.dart';

class FillAttendanceController extends GetxController {
  UserRepository userRepository;
  PlaceRepository placeRepository;
  AttendanceRepository attendanceRepository;
  FillAttendanceController({
    required this.userRepository,
    required this.placeRepository,
    required this.attendanceRepository,
  });

  late GoogleMapController mapController;
  final googlePles = LatLng(37, -122);
  final RxSet<Marker> markers = <Marker>{}.obs;
  final RxSet<Circle> circles = <Circle>{}.obs;
  final RxMap<PolylineId, Polyline> polylines = RxMap.identity();
  final RxList<LatLng> polylineCoordinates = RxList.empty();
  final Rx<LatLng?> currentPosition = (null as LatLng?).obs;
  final PolylinePoints polylinePoints = PolylinePoints();
  final place = (null as Place?).obs;
  final user = (null as User?).obs;
  final currentAttendance = (null as Attendance?).obs;

  onMapCreated(GoogleMapController mController) {
    mapController = mController;
  }

  setCurrentPosition(LatLng position) {
    currentPosition.value = position;
  }

  bool makeAttendance() {
    if (currentPosition.value!.distance(place.value!.latLng) <= 1) { //User must inside the circle (in 1km)
      print("Attendance distance: ${currentPosition.value!.distance(place.value!.latLng)}");
      if (currentAttendance.value == null) {
        var newAttendance = Attendance(
          userId: user.value!.uid,
          placeId: place.value!.id,
          checkInTime: DateTime.now(),
        );
        var attendances = attendanceRepository.readAttendances();
        attendances.add(newAttendance);
        attendanceRepository.writeAttendances(attendances);
      } else {
        var newAttendance =
            currentAttendance.value!.copyWith(checkOutTime: DateTime.now());
        var attendances = attendanceRepository.readAttendances();
        var index = attendances.indexOf(currentAttendance.value!);
        attendances[index] = newAttendance;
        attendanceRepository.writeAttendances(attendances);
      }
      return true;
    }
    return false;
  }

  Future<void> fetchLocationUpdates(Location locationController) async {
    bool serviceEnabled;

    serviceEnabled = await locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await locationController.requestService();
    } else {
      return;
    }

    var status = await Permission.location.status;
    if (!status.isGranted) {
      status = (await [Permission.location].request()) as PermissionStatus;
      if (await Permission.location.isPermanentlyDenied) {
        openAppSettings();
        return;
      }
    }

    locationController.onLocationChanged.listen((currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        currentPosition.value = LatLng(
          currentLocation.latitude!,
          currentLocation.longitude!,
        );
        makeLines(); //Create direction when user location updated
      }
    });
  }

  @override
  void onInit() {
    user.value = userRepository.getUser();
    place.value = placeRepository.readSelectedPlace()[0];
    currentAttendance.value = attendanceRepository
        .readAttendances()
        .firstWhereOrNull(
            (x) => x.userId == user.value!.uid && x.checkOutTime == null);

    markers.add(
      Marker(
          markerId: MarkerId(place.value!.title),
          position: place.value!.latLng,
          infoWindow: InfoWindow(title: place.value!.title)),
    );
    circles.add(
      Circle(
        circleId: CircleId(place.value!.title),
        center: place.value!.latLng,
        radius: 1000.0,
        fillColor: StyleColor.circleColor,
        strokeColor: StyleColor.primary,
      ),
    );
    super.onInit();
  }

  void makeLines() async {
    await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(
          currentPosition.value!.latitude,
          currentPosition.value!.longitude,
        ),
        destination: PointLatLng(
          place.value!.latLng.latitude,
          place.value!.latLng.longitude,
        ),
        mode: TravelMode.driving,
      ),
      googleApiKey: "AIzaSyB-FAKHTBXx7Cui8JMelwmCDN9W1CCCF2s"
    ).then((value){
      value.points.forEach((point){
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }).then((value){
      addPolyline();
    }).catchError((err){
      print(err);
      print("User latlng: ${currentPosition.value!}");
      print("Place latlng: ${place.value!.latLng}");
  });
  }
  
  void addPolyline() {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(polylineId: id, color: StyleColor.primary, points: polylineCoordinates);
    polylines[id] = polyline;
  }
}
