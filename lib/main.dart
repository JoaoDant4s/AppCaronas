import 'package:caronas/screen/car_details.dart';
import 'package:caronas/screen/home.dart';
import 'package:caronas/screen/login.dart';
import 'package:caronas/screen/new_account.dart';
import 'package:caronas/screen/new_car.dart';
import 'package:caronas/screen/register_ride.dart';
import 'package:caronas/screen/search.dart';
import 'package:caronas/services/auth_service.dart';
import 'package:caronas/theme/theme.dart';
import 'package:caronas/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  // await FirebaseAppCheck.instance.activate(
  //   webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  //   androidProvider: AndroidProvider.debug,
  //   appleProvider: AppleProvider.appAttest,
  // );
  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'EasyRide',
        debugShowCheckedModeBanner: false,
        theme: MyTheme.customTheme,
        home: Consumer<AuthService>(
          builder: (context, auth_service, child) {
            if (auth_service.userIsAuthenticated) {
              return Home();
            } else {
              return Login();
            }
          },
        ),
        routes: {
          AppRoutes.LOGIN: (context) => Login(),
          AppRoutes.SEARCH: (context) => Search(),
          AppRoutes.REGISTER: (context) => Register(),
          AppRoutes.NEWACCOUNT: (context) => CadastroLogin(),
          AppRoutes.NEWCAR: (context) => NewCar(),

          },
        );
  }
}
