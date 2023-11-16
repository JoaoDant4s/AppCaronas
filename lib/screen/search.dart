import 'package:caronas/components/ride_list_view.dart';
import 'package:caronas/components/search_bar_ride.dart';
import 'package:caronas/models/ride.dart';
import 'package:caronas/services/ride_service.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Ride> _rides = [];
  List<Ride> _filteredRides = [];

  _searchRides(String origin, String destiny) {
    List<Ride> searchResults = _rides.where((ride) {
      bool isInOrigin = false;
      bool isInDestiny = false;
      if (origin.isNotEmpty) {
        isInOrigin = ride.origin.toLowerCase().contains(origin.toLowerCase());
      }
      if (destiny.isNotEmpty) {
        isInDestiny =
            ride.destiny.toLowerCase().contains(destiny.toLowerCase());
      }
      return isInOrigin || isInDestiny;
    }).toList();
    setState(() {
      _filteredRides = List.from(searchResults);
      if (origin.isEmpty && destiny.isEmpty) {
        _filteredRides = List.from(_rides);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadRides();
  }

  _loadRides() async {
    List<Ride> rides = await getAllRides();
    setState(() {
      _rides = rides;
      _filteredRides = List.from(_rides);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        backgroundColor: const Color(0xFF09C184),
        title: const Text(
          'Look for a ride',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SearchBarRide(_searchRides),
          Visibility(
            visible: _filteredRides.isNotEmpty,
            child: Expanded(
              child: RideList(_filteredRides),
            ),
          ),
          Visibility(
            visible: _filteredRides.isEmpty,
            child: const Center(
              child: Text(
                "No rides found",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF09C184),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
