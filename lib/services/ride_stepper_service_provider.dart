import 'package:flutter/material.dart';

class RideStepperService extends ChangeNotifier {
  int currentStep = 0;
  

  nextStep() {
    if (currentStep < 2) {
      currentStep++;
      notifyListeners();
    }
  }

  prevStep() {
    if (currentStep > 0) {
      currentStep--;
      notifyListeners();
    }
  }

  stepTapped(int index) {
    currentStep = index;
    notifyListeners();
  }

  StepState handleState(String step) {
    switch (step) {
      case 'origin':
        if (currentStep == 0) {
          return StepState.indexed;
        } else if (currentStep >= 1) {
          return StepState.complete;
        } else {
          return StepState.disabled;
        }
      case 'destiny':
        if (currentStep == 1) {
          return StepState.indexed;
        } else if (currentStep >= 2) {
          return StepState.complete;
        } else {
          return StepState.disabled;
        }
      case 'details':
        return currentStep != 2 ? StepState.disabled : StepState.indexed;
      default:
        return StepState.disabled;
    }
  }

  Widget controlBuilder(context, details) {
    return const SizedBox(
      width: 0,
      height: 0,
    );
  }
}
