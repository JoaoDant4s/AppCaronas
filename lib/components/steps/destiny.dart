import 'package:caronas/services/location_service_provider.dart';
import 'package:caronas/services/ride_stepper_service_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DestinyStep extends StatefulWidget {
  const DestinyStep({super.key});

  @override
  State<DestinyStep> createState() => _DestinyStepState();
}

class _DestinyStepState extends State<DestinyStep> {
  late LocationService locationService;
  late RideStepperService rideStepperService;
  final _destinyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    rideStepperService =
        Provider.of<RideStepperService>(context, listen: false);
    locationService = Provider.of<LocationService>(context, listen: false);

    onMapTap(LatLng tappedPosition) async {
      try {
        await rideStepperService.selectPositionOnMap(tappedPosition);
        String address =
            await locationService.coordinatesToAddress(tappedPosition);
        _destinyController.text = address;
      } catch (e) {
        print("An error ocurred: $e");
      }
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.78,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: rideStepperService.destinyPosition != null
                        ? LatLng(rideStepperService.destinyPosition!.latitude,
                            rideStepperService.destinyPosition!.longitude)
                        : rideStepperService.originPosition!,
                    zoom: 14,
                  ),
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  onTap: (LatLng tappedPosition) {
                    onMapTap(tappedPosition);
                  },
                  markers: rideStepperService.markers,
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
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
                      controller: _destinyController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Type the destiny address here',
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
            ),
          ),
        ],
      ),
    );
  }
}
