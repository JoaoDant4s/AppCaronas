import 'package:caronas/components/search_bar_ride.dart';
import 'package:caronas/models/ride.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  _searchRides(String origin, String destiny) {}

  List<Ride> _rides = [
    Ride(
      id: '1',
      origin: 'Nevaldo Rocha, Natal, RN',
      destiny: 'Prudente de Morais, Natal, RN',
      price: 23.50,
      date: DateTime.now(),
      seats: 4,
    ),
    Ride(
      id: '2',
      origin: 'Salgado Filho, Natal, RN',
      destiny: 'Prudente de Morais, Natal, RN',
      price: 13.50,
      date: DateTime.now(),
      seats: 3,
    ),
    Ride(
      id: '3',
      origin: 'Engenheiro Roberto Freire, Natal, RN',
      destiny: 'Rua Beija Flor, Pipa, RN',
      price: 300,
      date: DateTime.now(),
      seats: 3,
    ),
  ];
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
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          SearchBarRide(),
        ],
      ),
    );
  }
}
