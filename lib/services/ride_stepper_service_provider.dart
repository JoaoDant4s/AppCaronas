import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideStepperService extends ChangeNotifier {
  int currentStep = 0;
  late GoogleMapController _originMapsController;
  late GoogleMapController _destinyMapsController;
  LatLng? originPosition;
  LatLng? destinyPosition;
  Set<Marker> markers = Set<Marker>();

  get originMapsController => _originMapsController;
  get destinyMapsController => _destinyMapsController;

  // onMapCreated(GoogleMapController gmc) async {
  //   if(currentStep == 0){
  //     _originMapsController = gmc;
  //   }

  // }

  nextStep() {
    if (currentStep < 2) {
      currentStep++;
      notifyListeners();
    }
  }

  prevStep() {
    if (currentStep > 0) {
      currentStep--;
      notifyListeners();
    }
  }

  stepTapped(int index) {
    currentStep = index;
    notifyListeners();
  }

  selectPositionOnMap(LatLng position) async {
    if (currentStep == 0) {
      originPosition = position;
      bool originMarkerExists =
          markers.any((marker) => marker.markerId.value == "originMarker");
      if (originMarkerExists) {
        markers
            .removeWhere((marker) => marker.markerId.value == "originMarker");
      }
      markers.add(
        Marker(
          markerId: const MarkerId("originMarker"),
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(), 'assets/images/origin_location_icon.png'),
          position: position,
        ),
      );
    } else {
      destinyPosition = position;
      bool destinyMarkerExists =
          markers.any((marker) => marker.markerId.value == "destinyMarker");
      if (destinyMarkerExists) {
        markers
            .removeWhere((marker) => marker.markerId.value == "destinyMarker");
      }
      markers.add(
        Marker(
          markerId: const MarkerId("destinyMarker"),
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(), 'assets/images/destiny_location_icon.png'),
          position: position,
        ),
      );
    }
    notifyListeners();
  }

  StepState handleState(String step) {
    switch (step) {
      case 'origin':
        if (currentStep == 0) {
          return StepState.indexed;
        } else if (currentStep >= 1) {
          return StepState.complete;
        } else {
          return StepState.disabled;
        }
      case 'destiny':
        if (currentStep == 1) {
          return StepState.indexed;
        } else if (currentStep >= 2) {
          return StepState.complete;
        } else {
          return StepState.disabled;
        }
      case 'details':
        return currentStep != 2 ? StepState.disabled : StepState.indexed;
      default:
        return StepState.disabled;
    }
  }

  Widget controlBuilder(context, details) {
    return const SizedBox(
      width: 0,
      height: 0,
    );
  }
}
