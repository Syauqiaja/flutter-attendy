import 'package:attendy_flutter/core/utils/decorations.dart';
import 'package:attendy_flutter/core/utils/parser.dart';
import 'package:attendy_flutter/core/values/colors.dart';
import 'package:attendy_flutter/modules/location/add_location/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddLocationPage extends GetView<AddLocationController> {
  const AddLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleColor.white,
        iconTheme: IconThemeData(color: StyleColor.primary),
        centerTitle: true,
        title: Text(
          "Add New Location",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          Obx(() {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  height: 400,
                  child: GoogleMap(
                    onTap: (argument) {
                      controller.addMarker(argument);
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(20, -100),
                      zoom: 12,
                    ),
                    onMapCreated: controller.onMapReady,
                    markers: controller.markers,
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: 200,
                  child: controller.markers.isEmpty
                      ? const Text(
                          "Lat: -; Lon: -;",
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          "Lat: ${controller.markers.first.position.latitude.toStringAsPrecision(5)}; Lon: ${controller.markers.first.position.longitude.toStringAsPrecision(5)};",
                          textAlign: TextAlign.center,
                        ),
                ),
              ],
            );
          }),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Place Title",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                      ),
                      TextFormField(
                        controller: controller.titleController,
                        cursorColor: StyleColor.primary,
                        decoration:
                            defaultInputDecoration("Write your place title"),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your place title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Full address",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                      ),
                      TextFormField(
                        controller: controller.fullAddressController,
                        cursorColor: StyleColor.primary,
                        decoration: defaultInputDecoration(
                            "Write the full address here"),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter the full address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Check in time",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    displayTimePicker(
                                        context, controller.checkInController);
                                  },
                                  child: TextFormField(
                                    enabled: false,
                                    controller: controller.checkInController,
                                    cursorColor: StyleColor.primary,
                                    decoration:
                                        defaultInputDecoration("XX:XX AM")
                                            .copyWith(
                                                suffixIcon: const Icon(
                                      Icons.timer_outlined,
                                      color: Colors.grey,
                                    )),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Fill this field';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Check out time",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    displayTimePicker(
                                        context, controller.checkOutController);
                                  },
                                  child: TextFormField(
                                    enabled: false,
                                    controller: controller.checkOutController,
                                    cursorColor: StyleColor.primary,
                                    decoration:
                                        defaultInputDecoration("XX:XX PM")
                                            .copyWith(
                                                suffixIcon: const Icon(
                                      Icons.timer_outlined,
                                      color: Colors.grey,
                                    )),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Fill this field';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        width: Get.width,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: StyleColor.primary),
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              if(controller.addLocation()){
                                Get.back();
                              }else{
                                showFailedDialog(context, "Pin location first", "");
                              }
                            }
                          },
                          child: Text(
                            "Create Location",
                            style: TextStyle(
                                color: StyleColor.white, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future displayTimePicker(
      BuildContext context, TextEditingController _controller) async {
    var time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (time != null) {
      _controller.text =
          "${time.hourOfPeriod}:${time.minute} ${time.period == DayPeriod.am ? "AM" : "PM"}";
    }
  }
}
