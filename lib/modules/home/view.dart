import 'package:attendy_flutter/core/utils/extensions.dart';
import 'package:attendy_flutter/core/values/colors.dart';
import 'package:attendy_flutter/modules/fill_attendance/view.dart';
import 'package:attendy_flutter/modules/home/controller.dart';
import 'package:attendy_flutter/modules/home/widgets/item_attendance_history.dart';
import 'package:attendy_flutter/modules/location/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleColor.primary,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Morning!",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: StyleColor.white,
                            ),
                          ),
                          Obx(
                            () => Text(
                              controller.user.value?.displayName != null
                                  ? controller.user.value!.displayName!
                                  : "Who are you?",
                              style: TextStyle(
                                  color: StyleColor.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(context: context, builder: alertDialog);
                        },
                        icon: Icon(
                          Icons.logout,
                          color: StyleColor.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(() {
                      return Row(
                        children: [
                          Icon(
                            Icons.place_outlined,
                            color: StyleColor.white,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            controller.place.value != null ? controller.place.value!.title : "-",
                            style: TextStyle(
                              color: StyleColor.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(() {
                      return Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Check in due:",
                                style: TextStyle(
                                    color: StyleColor.white, fontSize: 12),
                              ),
                              Text(
                                controller.place.value != null ? controller.place.value!.checkInTime : "-",
                                style: TextStyle(
                                  color: StyleColor.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Check out at:",
                                style: TextStyle(
                                    color: StyleColor.white, fontSize: 12),
                              ),
                              Text(
                                controller.place.value != null ? controller.place.value!.checkOutTime : "-",
                                style: TextStyle(
                                  color: StyleColor.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              alignment: AlignmentDirectional.centerEnd,
                              child: OutlinedButton(
                                onPressed: () {
                                  Get.toNamed('/location');
                                },
                                style: OutlinedButton.styleFrom(
                                  side:
                                      BorderSide(color: StyleColor.white, width: 1),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.zero),
                                  ),
                                ),
                                child: Text(
                                  "View Details",
                                  style: TextStyle(color: StyleColor.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  )
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0)),
                      color: StyleColor.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Attendance History",
                          style: TextStyle(
                              fontSize: 16,
                              color: StyleColor.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        controller.attendances.isNotEmpty
                            ? ItemAttendanceHistory(
                                attendance: controller.attendances.first)
                            : Container(),
                        ...controller.attendances.length > 1
                            ? controller.attendances
                                .getRange(1, controller.attendances.length)
                                .map((element) =>
                                    ItemAttendanceHistory(attendance: element))
                            : [Container()],
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: StyleColor.primary,
        onPressed: () {
          Get.toNamed('/attend');
        },
        icon: Icon(
          Icons.check_box_outlined,
          color: StyleColor.white,
        ),
        label: Text(
          "Fill Attendace",
          style: TextStyle(color: StyleColor.white),
        ),
      ),
    );
  }

  Widget alertDialog(context) => AlertDialog(
        title: Text('Confirm Logout'),
        content: Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Return false to cancel logout
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Return true to confirm logout
              controller.signOut();
            },
            child: Text('Logout'),
          ),
        ],
      );
}
