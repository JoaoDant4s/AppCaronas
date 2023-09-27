import 'package:caronas/models/user.dart';
import 'package:caronas/utils/app_routes.dart';
import 'package:flutter/material.dart';

class BottomModal extends StatelessWidget {
  final User user;
  BottomModal(this.user);

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border(
            top: BorderSide(
      color: Colors.black,
      width: 3.0,
    )));
  }

  bool checkUserCar() {
    return user.car != null ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    myDialog() {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Failed'),
            content: const Text('The user doesnt has car'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
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
          Row(
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
                        decoration: BoxDecoration(
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
                child: GestureDetector(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/gifs/volante.gif"),
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
                  onTap: () {
                    bool hasCar = checkUserCar();
                    if (!hasCar) {
                      myDialog();
                      return;
                    }
                    Navigator.of(context).pushNamed(AppRoutes.REGISTER);
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
