import 'package:flutter/material.dart';
import 'package:caronas/components/ride_list_view.dart';
import 'package:caronas/models/ride.dart';
import 'package:caronas/services/ride_service.dart';
import 'package:provider/provider.dart';
import 'package:caronas/services/auth_service_provider.dart';

class RideHistoryPage extends StatefulWidget {
  const RideHistoryPage({Key? key}) : super(key: key);

  @override
  _RideHistoryPageState createState() => _RideHistoryPageState();
}

class _RideHistoryPageState extends State<RideHistoryPage> {
  List<Ride> _rides = [];

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context, listen: true);

    _loadRidesHistory() async {
      if (authService.user != null) {
        List<Ride> rides = await getRideByUser(authService.user!.id!);
        setState(() {
          _rides = rides;
        });
      }
    }

    _loadRidesHistory();

    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        backgroundColor: const Color(0xFF09C184),
        title: const Text(
          'Ride history',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
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
          Visibility(
            visible: _rides.isNotEmpty,
            child: Expanded(
              child: RideList(_rides),
            ),
          ),
          Visibility(
            visible: _rides.isEmpty,
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
