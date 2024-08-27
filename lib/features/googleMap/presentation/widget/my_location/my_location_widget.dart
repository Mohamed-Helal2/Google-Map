import 'package:flutter/material.dart';
 import 'package:googlemap/features/googleMap/presentation/widget/my_location/location_photo_widget.dart';

class MyLocationWidget extends StatelessWidget {
  const MyLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      bottom: 20,
      right: 5,
      child: location_photo_widget(),
    );
  }
}

