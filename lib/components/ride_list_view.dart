import 'package:caronas/components/card.dart';
import 'package:flutter/material.dart';
import 'package:caronas/models/ride.dart';
import 'package:caronas/screen/ride_details.dart';

class RideList extends StatelessWidget {
  final List<Ride> _rides;

  RideList(this._rides);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 20),
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: _rides.length,
        itemBuilder: (context, index) {
          final ride = _rides[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RideDetailPage(ride: ride),
                ),
              );
            },
            child: CardRide(ride),
          );
        },
      ),
    );
  }
}
