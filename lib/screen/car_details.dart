import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/car.dart';
import '../services/auth_service_provider.dart';

class CarDetail extends StatefulWidget {
  final Car car;

  const CarDetail(this.car);

  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController licensePlateController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController availableSeatsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    brandController.text = widget.car.brand ?? "";
    modelController.text = widget.car.model ?? "";
    yearController.text = widget.car.year?.toString() ?? "";
    licensePlateController.text = widget.car.licensePlate ?? "";
    colorController.text = widget.car.color ?? "";
    availableSeatsController.text = widget.car.availableSeats?.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF09C184),
        title: Text(
          'Car Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  Icons.directions_car,
                  size: 100,
                  color: const Color(0xFF09C184),
                ),
              ),
              SizedBox(height: 20),
              buildInputField(brandController, 'Brand', isString: true),
              buildInputField(modelController, 'Model', isString: true),
              buildInputField(yearController, 'Year',
                  isNumeric: true, isRequired: true),
              buildInputField(licensePlateController, 'License Plate',
                  isString: true),
              buildInputField(colorController, 'Color', isString: true),
              buildInputField(availableSeatsController, 'Available Seats',
                  isNumeric: true, isRequired: true),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: buildButton(
                      text: 'Save',
                      color: const Color(0xFF09C184),
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          widget.car.brand = brandController.text;
                          widget.car.model = modelController.text;
                          widget.car.year =
                              int.tryParse(yearController.text) ?? 0;
                          widget.car.licensePlate = licensePlateController.text;
                          widget.car.color = colorController.text;
                          widget.car.availableSeats =
                              int.tryParse(availableSeatsController.text) ?? 0;

                          try {
                            await authService.updateCarInFirestore(widget.car);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content:
                                    Text('Car details updated successfully!'),
                              ),
                            );
                          } catch (error) {
                            print('Error updating the car: $error');
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: buildButton(
                      text: 'Delete',
                      color: Colors.red,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Deletion Confirmation'),
                              content: Text(
                                  'Are you sure you want to delete this car?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      if (widget.car.id != null) {
                                        await authService
                                            .deleteCarFromFirestore(
                                                widget.car.id!);
                                        authService.user?.setCar(null);
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      }
                                    } catch (_) {
                                      print('Error deleting the car.');
                                    }
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField(TextEditingController controller, String label,
      {bool isNumeric = false,
      bool isString = false,
      bool isRequired = false}) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (isRequired && (value?.isEmpty ?? true)) {
            return 'This field is required.';
          }
          if (isString && (value?.isEmpty ?? false)) {
            return 'This field is required.';
          }
          if (isNumeric &&
              (value?.isNotEmpty ?? false) &&
              int.tryParse(value!) == null) {
            return 'Please enter a valid number.';
          }
          return null;
        },
      ),
    );
  }

  Widget buildButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
