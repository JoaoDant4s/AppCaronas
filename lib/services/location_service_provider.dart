import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as GeoCoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  Future<String> coordinatesToAddress(LatLng coordinates) async {
    List<GeoCoding.Placemark> placemarks =
        await GeoCoding.placemarkFromCoordinates(
            coordinates.latitude, coordinates.longitude);
    GeoCoding.Placemark placeTarget = placemarks[0];
    return "${placeTarget.street} ${placeTarget.name}, ${placeTarget.subAdministrativeArea}, ${placeTarget.administrativeArea}";
  }

  Future<LatLng> addressToCoordinates(String address) async {
    List<GeoCoding.Location> locations =
        await GeoCoding.locationFromAddress(address);
    GeoCoding.Location locationTarget = locations[0];
    return LatLng(locationTarget.latitude, locationTarget.longitude);
  }
}
