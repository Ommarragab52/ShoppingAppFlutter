import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/core/services/location_service.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_app_bar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late MapController mapController;
  late double currentZoom;
  late LatLng currentLatLng;
  bool isLoading = false;
  bool showMarker = false;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    currentLatLng = const LatLng(30.284465, 31.134591);
    currentZoom = 5;
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Maps'),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          onTap: (tapPosition, point) {
            setState(() {
              showMarker = true;
              currentLatLng = point;
              mapController.moveAndRotate(point, currentZoom, 1);
            });
          },
          onPositionChanged: (camera, hasGesture) {
            setState(() {
              currentLatLng = camera.center;
              currentZoom = camera.zoom;
            });
            log(currentLatLng.toString());
          },
          initialCenter: currentLatLng,
          // Center the map over London
          initialZoom: currentZoom,
        ),
        children: [
          TileLayer(
            // Bring your own tiles
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            // For demonstration only
            userAgentPackageName: 'com.example.app', // Add your app identifier
            // And many more recommended properties!
          ),
          MarkerLayer(
            markers: [
              Marker(
                alignment: const Alignment(-0.55, -2),
                point: currentLatLng,
                child: showMarker
                    ? const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 48,
                      )
                    : const SizedBox.shrink(),
              )
            ],
          ),

          // Also add images...
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // get current location from GPS
          LocationService.getCurrentPosition().then(
            (position) {
              setState(() {
                showMarker = true;
                currentLatLng = LatLng(position.latitude, position.longitude);
                mapController.moveAndRotate(currentLatLng, 13, 1);
              });
            },
          ).onError(
            (error, stackTrace) {
              ScaffoldMessenger.of(context).showSnackBar(
                appSnackBar(
                    content: error.toString(), state: SnackBarState.error),
              );
            },
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.gps_fixed,
          color: Colors.red,
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: AppButton(
            onPressed: () {
              LocationService.getLocationDetails(
                      currentLatLng.latitude, currentLatLng.longitude)
                  .then(
                (placeMark) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    appSnackBar(
                        content:
                            '${placeMark.street},${placeMark.locality},${placeMark.administrativeArea} ,${placeMark.country}',
                        state: SnackBarState.success),
                  );
                },
              ).onError(
                (error, stackTrace) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    appSnackBar(
                        content: error.toString(), state: SnackBarState.error),
                  );
                },
              );
            },
            text: 'Confirm'),
      ),
    );
  }
}
