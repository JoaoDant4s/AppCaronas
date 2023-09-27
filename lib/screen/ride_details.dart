import 'package:flutter/material.dart';
import 'package:caronas/models/ride.dart';

class RideDetailPage extends StatelessWidget {
  final Ride ride;

  const RideDetailPage({required this.ride});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF09C184),
        title: const Text(
          'Ride details',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           const Text(
              'Origin:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              ride.origin,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
           const Text(
              'Destination:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              ride.destiny,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Date:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '${ride.date.day}/${ride.date.month}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Price:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'R\$ ${ride.price.toStringAsFixed(2)}',
              style:const TextStyle(fontSize: 16),
            ),
           const SizedBox(height: 16),
            const Text(
              'Available seats:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
           const SizedBox(height: 4),
            Text(
              ride.seats.toString(),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
