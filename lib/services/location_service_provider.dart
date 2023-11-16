import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationService extends ChangeNotifier {
  final Location _location = Location();
  LocationData? _userLocation;
  bool? _allowedLocation;

  LocationData? get userLocation => _userLocation;
  bool? get allowedLocation => _allowedLocation;

  Future<void> hasPermissions() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        _allowedLocation = false;
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        _allowedLocation = false;
      }
    }

    _allowedLocation = true;
  }

  Future<void> calcUserLocation() async {
    LocationData locationData = await _location.getLocation();
    _userLocation = locationData;
    notifyListeners();
  }
}
