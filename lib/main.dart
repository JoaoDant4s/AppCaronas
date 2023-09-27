import 'package:caronas/screen/home.dart';
import 'package:caronas/screen/login.dart';
import 'package:caronas/screen/my_profile.dart';
import 'package:caronas/screen/new_account.dart';
import 'package:caronas/screen/register_ride.dart';
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
        initialRoute: '/login',
        routes: {
          AppRoutes.HOME: (context) => Home(),
          AppRoutes.LOGIN: (context) => Login(),
          AppRoutes.SEARCH: (context) => Search(),
          AppRoutes.REGISTER: (context) => Register(),
          AppRoutes.NEWACCOUNT: (context) => CadastroLogin(),
        });
  }
}
