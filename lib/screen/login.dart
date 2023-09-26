import 'package:flutter/material.dart';
import 'package:caronas/utils/app_routes.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Stack(
                    children: <Widget>[
                      Image(
                        image: AssetImage("assets/images/car2d.png"),
                        width: 1388,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  decoration: InputDecoration(labelText: 'E-mail'),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 40),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: Container(
                    color: Colors.white,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Log In',
                          style: TextStyle(color: Colors.white,fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.NEWACCOUNT);
                  },
                  child: Text('Create new account',style: TextStyle(fontSize: 14,color: Colors.green),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
