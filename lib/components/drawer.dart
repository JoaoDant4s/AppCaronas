import 'dart:io';

import 'package:caronas/data/login_data.dart';
import 'package:caronas/models/user.dart';
import 'package:caronas/screen/my_profile.dart';
import 'package:caronas/utils/app_routes.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  final User _myUser;

  HomeDrawer(this._myUser);

  @override
  Widget build(BuildContext context) {
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
                      child: CircleAvatar(
                        backgroundImage: AssetImage(_myUser.image!.path),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _myUser.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
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
                              _myUser.rating.toString(),
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
                          _myUser,
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
                    Icon(Icons.directions_car, size: 30),
                    SizedBox(width: 10),
                    Text(
                      "My rides",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.popUntil(context, ModalRoute.withName("/login"));
                  },
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
