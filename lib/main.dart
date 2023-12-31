import 'package:caronas/firebase_messaging.dart';
import 'package:caronas/screen/home.dart';
import 'package:caronas/screen/login.dart';
import 'package:caronas/screen/new_account.dart';
import 'package:caronas/screen/new_car.dart';
import 'package:caronas/screen/register_ride.dart';
import 'package:caronas/screen/search.dart';
import 'package:caronas/services/auth_service_provider.dart';
import 'package:caronas/services/location_service_provider.dart';
import 'package:caronas/theme/theme.dart';
import 'package:caronas/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'firebase_config.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await initializeFirebase();
  await FirebaseNotifications().initNotifications();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(
          create: (context) => AuthService(),
        ),
        ChangeNotifierProvider<LocationService>(
          create: (context) => LocationService(),
        )
      ],
      child: MyApp(),
    ),
  );
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
      navigatorKey: navigatorKey,
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
