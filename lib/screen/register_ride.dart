import 'package:caronas/components/snackbar.dart';
import 'package:caronas/errors/rideException.dart';
import 'package:caronas/models/ride.dart';
import 'package:flutter/material.dart';
import 'package:caronas/services/ride_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterRideState();
}

class _RegisterRideState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  final _origin = TextEditingController();
  final _destiny = TextEditingController();
  final _price = TextEditingController();
  final _seats = TextEditingController();

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

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

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
          _selectedDate = pickedDate;
        });
      });
    }

    void registerRide() async {
    
      String origin = _origin.text;
      String destiny = _destiny.text;
      double price = double.parse(_price.text);
      DateTime date = _selectedDate;
      int seats = int.parse(_seats.text);

      Ride newRide = Ride(
        id: UniqueKey().toString(),
        origin: origin,
        destiny: destiny,
        price: price,
        date: date,
        seats: seats,
      );

      try {
        String rideId = await createRide(newRide);
        newRide.setId(rideId);

        resetInputs();

        Navigator.of(context).popUntil((route) => route.isFirst);
        CustomSnackBar.showSnackBar(
          context,
          "Ride registered successfully",
          Colors.green,
          Colors.white,
        );
      } catch (error) {
        if (error is RideException) {
          CustomSnackBar.showSnackBar(
            context,
            error.message,
            Colors.red,
            Colors.white,
          );
        } else {
          CustomSnackBar.showSnackBar(
            context,
            "Internal server error",
            Colors.red,
            Colors.white,
          );
        }
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF09C184),
        title: const Text(
          'Register your ride here',
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
      body: SingleChildScrollView(
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
                      const SizedBox(height: 20.0),
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
                          controller: _origin,
                          decoration: const InputDecoration(
                            labelText: 'Origin',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.location_on),
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
                          controller: _destiny,
                          decoration: const InputDecoration(
                            labelText: 'Destiny',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.location_on),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
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
                                    "${_selectedDate.toLocal()}".split(' ')[0],
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
                          controller: _price,
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
                          controller: _seats,
                          decoration: const InputDecoration(
                            labelText: 'Available seats',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.event_seat),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF09C184),
                                padding: const EdgeInsets.all(20.0),
                              ),
                              onPressed: registerRide,
                              child: const Text(
                                'Create',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}