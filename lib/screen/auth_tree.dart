import 'package:caronas/models/auth.dart';
import 'package:caronas/screen/home.dart';
import 'package:caronas/screen/login.dart';
import 'package:flutter/material.dart';

class AuthTree extends StatefulWidget {
  const AuthTree({super.key});

  @override
  State<AuthTree> createState() => _AuthTreeState();
}

class _AuthTreeState extends State<AuthTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Home(snapshot.data);
        } else {
          return const Login();
        }
      },
    );
  }
}
