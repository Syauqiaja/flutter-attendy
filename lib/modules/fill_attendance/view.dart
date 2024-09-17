import 'dart:math';

import 'package:attendy_flutter/core/utils/parser.dart';
import 'package:attendy_flutter/core/values/colors.dart';
import 'package:attendy_flutter/modules/fill_attendance/controller.dart';
import 'package:attendy_flutter/modules/fill_attendance/widgets/failed_dialog.dart';
import 'package:attendy_flutter/modules/fill_attendance/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' hide PermissionStatus;
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:slide_to_act/slide_to_act.dart';

class FillAttendancePage extends GetView<FillAttendanceController> {
  final locationController = Location();

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized()
        .addPostFrameCallback((timeStamp) async {
      controller.fetchLocationUpdates(locationController);
    });

    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: StyleColor.white,
          iconTheme: IconThemeData(color: StyleColor.primary),
          centerTitle: true,
          title: const Text(
            "Do Attendance",
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() {
                return Container(
                  width: Get.width,
                  color: StyleColor.white_2,
                  child: controller.currentPosition.value == null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 70.0,
                              height: 70.0,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: StyleColor.primary,
                                ),
                              ),
                            ),
                            const Text("Loading your maps")
                          ],
                        )
                      : GoogleMap(
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          initialCameraPosition: CameraPosition(
                            target: controller.currentPosition.value!,
                            zoom: 13,
                          ),
                          onMapCreated: controller.onMapCreated,
                          markers: controller.markers,
                          circles: {
                            Circle(
                                circleId: CircleId("DA"),
                                center: controller.place.value!.latLng,
                                radius: 100,
                                strokeColor: StyleColor.primary,
                                strokeWidth: 1,
                                fillColor: StyleColor.circleColor)
                          },
                          polylines: controller.polylines.values.toSet(),
                        ),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.place.value == null
                        ? ""
                        : controller.place.value!.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    controller.place.value == null
                        ? ""
                        : controller.place.value!.fullAddress,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                      color: StyleColor.black_2,
                    ),
                  ),
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Punch in",
                                style: TextStyle(
                                  color: StyleColor.black_2,
                                ),
                              ),
                              Text(
                                controller.currentAttendance.value == null
                                    ? "NOW"
                                    : DateFormat("hh:mm a").format(controller
                                        .currentAttendance.value!.checkInTime),
                                style:
                                    controller.currentAttendance.value == null
                                        ? TextStyle(
                                            color: StyleColor.primary,
                                            fontWeight: FontWeight.w600)
                                        : TextStyle(
                                            color: StyleColor.black,
                                            fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 32,
                          ),
                          Column(
                            children: [
                              Text(
                                "Punch out",
                                style: TextStyle(
                                  color: StyleColor.black_2,
                                ),
                              ),
                              Text(
                                controller.currentAttendance.value == null
                                    ? "---"
                                    : "Now",
                                style:
                                    controller.currentAttendance.value == null
                                        ? TextStyle(
                                            color: StyleColor.black,
                                            fontWeight: FontWeight.w400)
                                        : TextStyle(
                                            color: StyleColor.primary,
                                            fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: SlideAction(
                        borderRadius: 8,
                        innerColor: StyleColor.white,
                        outerColor: StyleColor.primary,
                        elevation: 0,
                        textStyle:
                            TextStyle(fontSize: 18, color: StyleColor.white),
                        text: "Slide to Punch In",
                        onSubmit: () {
                          if (!controller.makeAttendance()) {
                            showFailedDialog(
                              context,
                              'Faile to make attendance',
                              'You have 1000m near your center area to be able to do Punch In (inside the red circle)',
                            );
                            return null;
                          } else {
                            showSucceSsDialog(
                                context, "Success creating attendance");
                          }
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "You have 1000m near your center area to be able to do Punch In (inside the red circle)",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
