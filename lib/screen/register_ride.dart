import 'package:caronas/components/steps/stepper.dart';
import 'package:caronas/services/ride_stepper_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterRideState();
}

class _RegisterRideState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF09C184),
        title: const Text(
          'Register your ride',
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
      body: ChangeNotifierProvider<RideStepperService>(
        create: (context) => RideStepperService(),
        child: RideStepper(),
      ),
    );
  }
}
