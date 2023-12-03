import 'package:caronas/models/app_user.dart';
import 'package:caronas/services/auth_service_provider.dart';
import 'package:caronas/services/location_service_provider.dart';
import 'package:caronas/utils/app_routes.dart';
import 'package:caronas/utils/check_car.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomModal extends StatefulWidget {
  final AppUser user;
  BottomModal(this.user);

  @override
  State<BottomModal> createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModal> {
  bool isLoading = false;
  BoxDecoration myBoxDecoration() {
    return const BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Colors.black,
          width: 3.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    LocationService locationService =
        Provider.of<LocationService>(context, listen: false);
    myDialog() {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Failed'),
            content: const Text('The user does not has a car'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('LATER'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.NEWCAR);
                },
                child: const Text('CREATE'),
              ),
            ],
          );
        },
      );
    }

    getUserLocation() async {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
        await locationService.calcUserLocation();
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushNamed(AppRoutes.REGISTER);
      }
    }

    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 14.0),
            padding: const EdgeInsets.only(bottom: 70.0),
            width: 70,
            decoration: myBoxDecoration(),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 120.0,
                              height: 120.0,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/gifs/espanhol.gif"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Text(
                              "Passenger",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes.SEARCH);
                        },
                      ),
                    ),
                    Expanded(
                      child: Consumer<AuthService>(
                        builder: (context, auth_service, child) {
                          return GestureDetector(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 120.0,
                                  height: 120.0,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage("assets/gifs/volante.gif"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "Driver",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                            onTap: () async {
                              bool hasCar = checkUserCar(auth_service.user!);
                              if (!hasCar) {
                                myDialog();
                                return;
                              }
                              await getUserLocation();
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
