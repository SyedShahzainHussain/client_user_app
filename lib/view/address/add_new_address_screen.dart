import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          GoogleMap(
              zoomControlsEnabled: true,
              myLocationEnabled: true,
              fortyFiveDegreeImageryEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(24.8607, 67.0011),
                zoom: 14.0,
              )),
        ],
      ),
    );
  }
}
