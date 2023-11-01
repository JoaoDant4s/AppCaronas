import 'package:caronas/screen/my_profile.dart';
import 'package:caronas/services/auth_service.dart';
import 'package:caronas/utils/app_routes.dart';
import 'package:caronas/utils/check_car.dart';
import 'package:caronas/utils/first_last_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen/car_details.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context, listen: true);

    void logOut() async {
      await authService.signOut();
    }

    return Drawer(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: authService.user!.image.isNotEmpty
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    Image.network(authService.user!.image)
                                        .image,
                              )
                            : const CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey,
                                child: Icon(CupertinoIcons.person_fill,
                                    size: 35, color: Colors.white),
                              ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 120),
                            child: Text(
                              getFirstAndLastName(authService.user!.name),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              authService.user!.rating.toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MyProfile(
                          authService.user!,
                        ),
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.person, size: 30),
                      SizedBox(width: 10),
                      Text(
                        "Profile",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Icon(Icons.fork_left_rounded, size: 30),
                    SizedBox(width: 10),
                    Text(
                      "My rides",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
                checkUserCar(authService.user!)
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (authService.user!.car != null) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => CarDetail(authService.user!.car!),
                                      ),
                                    );
                                  }
                                },
                                child: const Row(
                                  children: [
                                    Icon(Icons.directions_car, size: 30),
                                    SizedBox(width: 10),
                                    Text(
                                      "My car",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: logOut,
                  child: const Row(
                    children: [
                      Icon(Icons.logout, size: 30),
                      SizedBox(width: 10),
                      Text(
                        "Logout",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
