import 'package:caronas/models/ride.dart';
import 'package:flutter/material.dart';

class CardRide extends StatelessWidget {
  final Ride ride;

  const CardRide(this.ride);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.transparent,
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  ride.destiny,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF09C184)),
                ),
                Text(
                  ride.origin,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        constraints: BoxConstraints(minWidth: 80),
                        child: Text('R\$ ${ride.price.toStringAsFixed(2)}')),
                    Container(
                      constraints: BoxConstraints(minWidth: 60),
                      child: Text(
                          '${ride.date.day.toString()}/${ride.date.month.toString()}'),
                    ),
                    Container(
                        constraints: BoxConstraints(minWidth: 60),
                        child: Text(ride.seats.toString()))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
