import 'package:caronas/screen/home.dart';
import 'package:caronas/screen/login.dart';
import 'package:caronas/screen/my_profile.dart';
import 'package:caronas/screen/new_account.dart';
import 'package:caronas/screen/register_ride.dart';
import 'package:caronas/screen/search.dart';
import 'package:caronas/services/auth_service.dart';
import 'package:caronas/theme/theme.dart';
import 'package:caronas/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'firebase_config.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();

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
              return Home(auth_service.user);
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
        });
  }
}
