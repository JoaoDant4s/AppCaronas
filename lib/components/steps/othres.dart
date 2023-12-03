import 'package:caronas/services/ride_stepper_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsStep extends StatefulWidget {
  const DetailsStep({super.key});

  @override
  State<DetailsStep> createState() => _RegisterRideState();
}

class _RegisterRideState extends State<DetailsStep> {
  final _formKey = GlobalKey<FormState>();
  final _origin = TextEditingController();
  final _destiny = TextEditingController();
  final _price = TextEditingController();
  final _seats = TextEditingController();

  late RideStepperService rideStepperService;

  @override
  Widget build(BuildContext context) {
    rideStepperService =
        Provider.of<RideStepperService>(context, listen: false);

    void resetInputs() {
      setState(() {
        _origin.clear();
        _destiny.clear();
      });
    }

    Future<void> _showDatePicker(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (pickedDate != null && pickedDate != rideStepperService.selectedDate) {
        setState(() {
          rideStepperService.selectedDate = pickedDate;
        });
      }
    }

    showDatePickerFunction() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2023))
          .then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          rideStepperService.selectedDate = pickedDate;
        });
      });
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.9),
                      offset: const Offset(2, 2),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 180.0,
                      height: 180.0,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/gifs/car.gif"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: Colors.black)),
                      height: 65,
                      child: Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.date_range),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  "${rideStepperService.selectedDate.toLocal()}"
                                      .split(' ')[0],
                                ),
                              ],
                            ),
                            TextButton(
                                onPressed: () => _showDatePicker(context),
                                child: const Text('Select date',
                                    style: TextStyle(
                                      color: Color(0xFF09C184),
                                    )))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: const Offset(0, 2),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: rideStepperService.price,
                        decoration: const InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.attach_money),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: const Offset(0, 2),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: rideStepperService.seats,
                        decoration: const InputDecoration(
                          labelText: 'Available seats',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.event_seat),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
