import 'package:caronas/services/location_service_provider.dart';
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
  final _originController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    locationService = Provider.of<LocationService>(context, listen: false);
    return FutureBuilder(
      future: locationService.calcUserLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.78,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Erro ao obter a localização.'),
          );
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.78,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            locationService.userLocation!.latitude ?? 34.043087,
                            locationService.userLocation!.longitude ??
                                -118.267616,
                          ),
                          zoom: 14,
                        ),
                        zoomControlsEnabled: false,
                        mapType: MapType.normal,
                        myLocationEnabled: true,
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
                            controller: _originController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Type an adress here',
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
      },
    );
  }
}
