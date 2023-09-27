import 'package:caronas/models/user.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  final User user;

  MyProfile(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF09C184),
        title: const Text(
          'Look for a ride',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(user.image!.path),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text('Name: ${user.name}',
                      style: const TextStyle(fontSize: 18.0)),
                  Text('Email: ${user.email}',
                      style: const TextStyle(fontSize: 18.0)),
                  Text('Gender: ${user.gender}',
                      style: const TextStyle(fontSize: 18.0)),
                  Text(
                      'Birth Date: ${user.birth.day}/${user.birth.month}/${user.birth.year}',
                      style: const TextStyle(fontSize: 18.0)),
                  Text('Rating: ${user.rating}',
                      style: const TextStyle(fontSize: 18.0)),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
