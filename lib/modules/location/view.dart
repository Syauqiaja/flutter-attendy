import 'package:attendy_flutter/core/utils/parser.dart';
import 'package:attendy_flutter/core/values/colors.dart';
import 'package:attendy_flutter/modules/home/controller.dart';
import 'package:attendy_flutter/modules/location/widgets/item_location.dart';
import 'package:attendy_flutter/modules/widgets/google_maps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final googlePles = LatLng(37, -122);
  final Set<Marker> markers = {};
  late GoogleMapController mapController;
  final HomeController homeController = Get.find<HomeController>();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleColor.primary,
      appBar: AppBar(
        backgroundColor: StyleColor.primary,
        iconTheme: IconThemeData(color: StyleColor.white),
        centerTitle: false,
        actions: [
          TextButton.icon(
            onPressed: () {
              showModalBottomSheet(context: context, builder: (context)=>bottomSheet());
            },
            label: Row(
              children: [
                Icon(
                  Icons.track_changes,
                  color: StyleColor.white,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "Change Location",
                  style: TextStyle(color: StyleColor.white),
                )
              ],
            ),
          ),
          TextButton.icon(
            onPressed: () {
              Get.toNamed('/location/add');
            },
            label: Row(
              children: [
                Icon(
                  Icons.add,
                  color: StyleColor.white,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "Add New",
                  style: TextStyle(color: StyleColor.white),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          )
        ],
      ),
      body: Obx(() {
        return ListView(
          children: [
            const SizedBox(
              height: 24,
            ),
            Center(
                child: Text(
              homeController.user.value?.displayName != null
                  ? homeController.user.value!.displayName!
                  : "Anonymous",
              style: TextStyle(
                color: StyleColor.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
            Center(
                child: Text(
              homeController.user.value?.email != null
                  ? homeController.user.value!.email!
                  : "-",
              style: TextStyle(
                color: StyleColor.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            )),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Days",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: StyleColor.white),
                      ),
                      Text(
                        '${homeController.totalDays.value} Days',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: StyleColor.white),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Absent: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: StyleColor.white),
                      ),
                      Text(
                        "${homeController.absent.value} Days",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: StyleColor.white),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Present: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: StyleColor.white),
                      ),
                      Text(
                        "${homeController.present.value} Days",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: StyleColor.white),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CircularStepProgressIndicator(
                        totalSteps: homeController.totalDays.value > 0
                            ? homeController.totalDays.value
                            : 1,
                        currentStep: homeController.present.value,
                        stepSize: 6,
                        padding: 0,
                        selectedColor: Colors.white,
                        unselectedColor: StyleColor.white_on_primary,
                        width: 150,
                        height: 150,
                        roundedCap: (p0, p1) => true,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Performance",
                                style: TextStyle(color: StyleColor.white),
                              ),
                              Text(
                                "${homeController.performance.value}%",
                                style: TextStyle(
                                    color: StyleColor.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: StyleColor.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(color: StyleColor.white_2),
                        child: googleMap(),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Text(
                        homeController.place.value != null
                            ? homeController.place.value!.title
                            : "-",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: StyleColor.black,
                            fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
                      child: Text(
                        homeController.place.value != null
                            ? homeController.place.value!.fullAddress
                            : "-",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: StyleColor.black,
                            fontSize: 14),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Punch in",
                              style: TextStyle(
                                color: StyleColor.black,
                              ),
                            ),
                            Text(
                              homeController.place.value != null
                                  ? homeController.place.value!.checkInTime
                                  : "-",
                              style: TextStyle(
                                  color: StyleColor.black,
                                  fontWeight: FontWeight.w600),
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
                                color: StyleColor.black,
                              ),
                            ),
                            Text(
                              homeController.place.value != null
                                  ? homeController.place.value!.checkOutTime
                                  : "-",
                              style: TextStyle(
                                  color: StyleColor.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: StyleColor.success,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Selected Location",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: StyleColor.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.check_circle,
                              size: 16,
                              color: StyleColor.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

// #region Google Maps
  Widget googleMap() {
    return Obx(() {
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: homeController.place.value != null ? homeController.place.value!.latLng : googlePles,
            zoom: 13,
          ),
          scrollGesturesEnabled: false,
          liteModeEnabled: true,
          onMapCreated: _onMapCreated,
          markers: homeController.place.value != null ? {Marker(markerId: MarkerId("Place"), position: homeController.place.value!.latLng)} : {},
        );
      }
    );
  }
// #endregion

  Widget bottomSheet() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: StyleColor.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: 100,
                  height: 5,
                  decoration: BoxDecoration(
                      color: StyleColor.white_2,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: false,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Select other location",
                            style: TextStyle(
                                fontSize: 16,
                                color: StyleColor.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Obx(() {
                            return Container(
                              child: Column(
                                children: [
                                  ...homeController.places.map((e) => Column(
                                        children: [
                                          Divider(
                                            indent: 12,
                                          ),
                                          ItemLocation(place: e,),
                                        ],
                                      ))
                                ],
                              ),
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
