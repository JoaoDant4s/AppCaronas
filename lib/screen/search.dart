import 'package:caronas/components/ride_list_view.dart';
import 'package:caronas/components/search_bar_ride.dart';
import 'package:caronas/data/my_cards.dart';
import 'package:caronas/models/ride.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  _searchRides(String origin, String destiny) {
    List<Ride> searchResults = _rides.where((ride) {
      return ride.origin.contains(origin) || ride.destiny.contains(destiny);
    }).toList();

    setState(() {
      setState(() {
        _filteredRides = List.from(searchResults);
      });
    });
  }

  List<Ride> _rides = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _rides = List.from(ridesData);
    });
  }

  List<Ride> _filteredRides = [];
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
            Navigator.pop(context);
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: <Widget>[
              SearchBarRide(_searchRides),
              RideList(_filteredRides.isEmpty ? _rides : _filteredRides),
            ],
          ),
        ),
      ),
    );
  }
}
