import 'package:caronas/components/steps/origin.dart';
import 'package:caronas/services/ride_stepper_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideStepper extends StatefulWidget {
  const RideStepper({super.key});

  @override
  State<RideStepper> createState() => _RideStepperState();
}

class _RideStepperState extends State<RideStepper> {
  @override
  Widget build(BuildContext context) {
    RideStepperService rideStepperService =
        Provider.of<RideStepperService>(context, listen: true);
    return Scaffold(
      floatingActionButton: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(20),
              margin: const EdgeInsets.only(left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color.fromRGBO(9, 193, 132, 1),
                        style: BorderStyle.solid,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: rideStepperService.prevStep,
                    child: const Text(
                      "Previous",
                      style: TextStyle(
                        color: Color(0xFF09C184),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF09C184),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: rideStepperService.nextStep,
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Stepper(
        connectorColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey;
            }
            return const Color(0xFF09C184);
          },
        ),
        elevation: 0,
        type: StepperType.horizontal,
        currentStep: rideStepperService.currentStep,
        onStepContinue: rideStepperService.nextStep,
        onStepTapped: rideStepperService.stepTapped,
        controlsBuilder: rideStepperService.controlBuilder,
        steps: [
          Step(
            title: const Text("Origin"),
            content: OriginStep(),
            isActive: rideStepperService.currentStep >= 0,
            state: rideStepperService.handleState('origin'),
          ),
          Step(
            title: const Text("Destiny"),
            content: Text("test"),
            isActive: rideStepperService.currentStep >= 1,
            state: rideStepperService.handleState('destiny'),
          ),
          Step(
            title: const Text("Details"),
            content: Text("test"),
            isActive: rideStepperService.currentStep == 2,
            state: rideStepperService.handleState('details'),
          ),
        ],
      ),
    );
  }
}
