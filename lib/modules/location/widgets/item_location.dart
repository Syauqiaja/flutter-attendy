import 'package:attendy_flutter/core/values/colors.dart';
import 'package:attendy_flutter/data/models/place.dart';
import 'package:attendy_flutter/modules/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemLocation extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  final Place place;
  ItemLocation({required this.place, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          homeController.selectPlace(place);
          Navigator.of(context).pop(); // Close the dialog
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Row(
            children: [
              Icon(
                Icons.share_location_outlined,
                size: 40,
                color: StyleColor.primary,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(place.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis),
                    Text(
                      place.fullAddress,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
