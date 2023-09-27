import 'dart:io';

import 'package:caronas/utils/app_routes.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});
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
                        backgroundImage:
                            AssetImage("assets/images/joao_dantas.jpg"),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nome do usuário
                        Text(
                          "João Dantas",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        // Avaliação do usuário
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "4.8",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.MYPROFILE);
                  },
                  child: Row(
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
                SizedBox(
                  height: 20,
                ),
                Row(
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
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(Icons.logout, size: 30),
                    SizedBox(width: 10),
                    Text(
                      "Logout",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 20),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
