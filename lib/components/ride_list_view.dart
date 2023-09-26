import 'package:caronas/components/card.dart';
import 'package:caronas/models/ride.dart';
import 'package:flutter/material.dart';

class RideList extends StatelessWidget {
  List<Ride> _rides;

  RideList(this._rides);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 1200,
        padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 20),
        child: ListView.builder(
          itemCount: _rides.length,
          itemBuilder: (context, index) {
            final ride = _rides[index];
            return CardRide(ride);
          },
        ),
      ),
    );
  }
}
