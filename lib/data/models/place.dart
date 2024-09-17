import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place{
  final LatLng latLng;
  final int id;
  final String title;
  final String fullAddress;
  final String checkInTime;
  final String checkOutTime;

  const Place({
    required this.latLng,
    required this.id,
    required this.title,
    required this.fullAddress,
    required this.checkInTime,
    required this.checkOutTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'latLng': {
        'latitude': latLng.latitude,
        'longitude': latLng.longitude,
      },
      'id': id,
      'title': title,
      'fullAddress': fullAddress,
      'checkInTime': checkInTime,
      'checkOutTime': checkOutTime,
    };
  }
  
  factory Place.fromJson(Map<String, dynamic> json) {
    final latLngJson = json['latLng'] as Map<String, dynamic>;
    return Place(
      latLng: LatLng(
        (latLngJson['latitude'] as num).toDouble(),
        (latLngJson['longitude'] as num).toDouble(),
      ),
      id: json['id'] as int,
      title: json['title'] as String,
      fullAddress: json['fullAddress'] as String,
      checkInTime: json['checkInTime'] as String,
      checkOutTime: json['checkOutTime'] as String,
    );
  }
}