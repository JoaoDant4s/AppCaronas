import 'package:caronas/components/snackbar.dart';
import 'package:caronas/errors/rideException.dart';
import 'package:caronas/models/ride.dart';
import 'package:caronas/services/ride_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideStepperService extends ChangeNotifier {
  int currentStep = 0;
  late GoogleMapController _originMapsController;
  late GoogleMapController _destinyMapsController;
  LatLng? originPosition;
  LatLng? destinyPosition;
  Set<Marker> markers = Set<Marker>();

  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final origin = TextEditingController();
  final destiny = TextEditingController();
  final price = TextEditingController();
  final seats = TextEditingController();

  get originMapsController => _originMapsController;
  get destinyMapsController => _destinyMapsController;

  // onMapCreated(GoogleMapController gmc) async {
  //   if(currentStep == 0){
  //     _originMapsController = gmc;
  //   }

  // }

  nextStep(BuildContext context, String driverID) {
    if (currentStep == 0) {
      if (origin.text.isNotEmpty) {
        currentStep++;
        notifyListeners();
      }
    } else if (currentStep == 1) {
      if (destiny.text.isNotEmpty) {
        currentStep++;
        notifyListeners();
      }
    } else {
      submitForm(context, driverID);
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

  void resetInputs() {
    origin.clear();
    destiny.clear();
    seats.clear();
    price.clear();
    selectedDate = DateTime.now();
  }

  void submitForm(BuildContext context, String driverID) async {
    // Armazena uma referência ao contexto
    BuildContext localContext = context;
    List<String> participants = [];
    double priceFormatted = double.parse(price.text);
    DateTime date = selectedDate;
    int seatsAvailable = int.parse(seats.text);

    Ride newRide = Ride(
      id: UniqueKey().toString(),
      driverID: driverID,
      participants: participants,
      origin: origin.text,
      destiny: destiny.text,
      price: priceFormatted,
      date: date,
      seats: seatsAvailable,
    );

    try {
      String rideId = await createRide(newRide);
      newRide.setId(rideId);

      resetInputs();

      Navigator.of(localContext).popUntil((route) => route.isFirst);
      CustomSnackBar.showSnackBar(
        localContext,
        "Ride registered successfully",
        Colors.green,
        Colors.white,
      );
    } catch (error) {
      if (error is RideException) {
        CustomSnackBar.showSnackBar(
          localContext,
          error.message,
          Colors.red,
          Colors.white,
        );
      } else {
        CustomSnackBar.showSnackBar(
          localContext,
          "Internal server error",
          Colors.red,
          Colors.white,
        );
      }
    }
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
      case 'others':
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
