import 'package:caronas/services/location_service_provider.dart';
import 'package:caronas/services/ride_stepper_service_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class OriginStep extends StatefulWidget {
  const OriginStep({super.key});

  @override
  State<OriginStep> createState() => _OriginStepState();
}

class _OriginStepState extends State<OriginStep> {
  late LocationService locationService;
  late RideStepperService rideStepperService;

  @override
  Widget build(BuildContext context) {
    locationService = Provider.of<LocationService>(context, listen: false);

    onMapTap(
        LatLng tappedPosition, RideStepperService rideStepperService) async {
      try {
        await rideStepperService.selectPositionOnMap(tappedPosition);
        String address =
            await locationService.coordinatesToAddress(tappedPosition);
        rideStepperService.origin.text = address;
      } catch (e) {
        print("An error ocurred: $e");
      }
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.78,
      child: Column(
        children: [
          Expanded(
            child: Consumer<RideStepperService>(
              builder: (context, rideStepperService, child) {
                return Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: rideStepperService.originPosition != null
                            ? LatLng(
                                rideStepperService.originPosition!.latitude,
                                rideStepperService.originPosition!.longitude)
                            : LatLng(
                                locationService.userLocation!.latitude!,
                                locationService.userLocation!.longitude!,
                              ),
                        zoom: 14,
                      ),
                      zoomControlsEnabled: false,
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      onTap: (LatLng tappedPosition) {
                        onMapTap(tappedPosition, rideStepperService);
                      },
                      markers: rideStepperService.markers,
                      gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>[
                        Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                        ),
                      ].toSet(),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: rideStepperService.origin,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Type the origin address here',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color(0xFF09C184),
                                  style: BorderStyle.solid),
                            ),
                            prefixIcon: const Icon(Icons.location_on),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
