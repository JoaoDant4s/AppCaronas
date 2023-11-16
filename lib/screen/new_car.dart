import 'package:caronas/components/snackbar.dart';
import 'package:caronas/errors/CarException.dart';
import 'package:caronas/models/car.dart';
import 'package:caronas/services/auth_service_provider.dart';
import 'package:caronas/services/car_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class NewCar extends StatefulWidget {
  const NewCar({super.key});

  @override
  State<NewCar> createState() => _NewCarState();
}

class _NewCarState extends State<NewCar> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _licensePlateController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  int availableSeats = 4;
  final loading = ValueNotifier<bool>(false);

  void resetInputs() {
    setState(() {
      _brandController.clear();
      _modelController.clear();
      _yearController.clear();
      _licensePlateController.clear();
      _colorController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context, listen: true);

    void registerCar() async {
      if (_formKey.currentState!.validate()) {
        loading.value = true;
        String licensePlate = _licensePlateController.text;
        String brand = _brandController.text;
        int year = int.parse(_yearController.text);
        String model = _modelController.text;
        String color = _colorController.text;

        Car newCar = Car(
          id: UniqueKey().toString(),
          licensePlate: licensePlate,
          brand: brand,
          year: year,
          model: model,
          color: color,
          availableSeats: availableSeats,
          userID: authService.user!.id!,
        );

        try {
          String carID = await createCar(newCar);
          newCar.setId(carID);
          authService.setCar(newCar);

          resetInputs();
          Navigator.of(context).popUntil((route) => route.isFirst);
          CustomSnackBar.showSnackBar(
            context,
            "Car registered successfully",
            Colors.green,
            Colors.white,
          );
        } catch (error) {
          if (error is CarException) {
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
        loading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF09C184),
        title: const Text(
          'Register car',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Stack(children: [
                Image(
                  image: AssetImage("assets/images/register_car.png"),
                  width: 600,
                  fit: BoxFit.cover,
                )
              ]),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Flexible(
                          flex: 5,
                          child: TextFormField(
                            controller: _licensePlateController,
                            decoration: const InputDecoration(
                              labelText: 'License plate',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'License plate is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Flexible(
                          flex: 4,
                          child: TextFormField(
                            controller: _brandController,
                            decoration: const InputDecoration(
                              labelText: 'Brand',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Brand is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            controller: _yearController,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              labelText: 'Year',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Year is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Flexible(
                          flex: 2,
                          child: TextFormField(
                            controller: _modelController,
                            decoration: const InputDecoration(
                              labelText: 'Model',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Model is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: TextFormField(
                            controller: _colorController,
                            decoration: const InputDecoration(
                              labelText: 'Color',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Color is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: Column(
                            children: [
                              const Text("Seats:             "),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: availableSeats > 1
                                        ? () {
                                            setState(() {
                                              availableSeats -= 1;
                                            });
                                          }
                                        : null,
                                  ),
                                  Text(
                                    '$availableSeats',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: availableSeats < 4
                                        ? () {
                                            setState(() {
                                              availableSeats += 1;
                                            });
                                          }
                                        : null,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF09C184),
                              padding: const EdgeInsets.all(10.0),
                            ),
                            onPressed: registerCar,
                            child: AnimatedBuilder(
                              animation: loading,
                              builder: (context, _) {
                                return loading.value
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        'Submit',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
