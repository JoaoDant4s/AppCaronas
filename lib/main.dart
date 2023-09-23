import 'package:caronas/screen/carpoolList.dart';
import 'package:caronas/screen/home.dart';
import 'package:caronas/screen/login.dart';
import 'package:caronas/screen/register.dart';
import 'package:caronas/screen/search.dart';
import 'package:caronas/theme/theme.dart';
import 'package:caronas/utils/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: MyTheme.customTheme,
        initialRoute: '/',
        routes: {
          AppRoutes.HOME: (context) => Home(),
          AppRoutes.LOGIN: (context) => Login(),
          AppRoutes.SEARCH: (context) => Search(),
          AppRoutes.CARPOOLLIST: (context) => CarpoolList(),
          AppRoutes.REGISTER: (context) => Register()
        });
  }
}
