import 'package:caronas/components/snackbar.dart';
import 'package:caronas/errors/AuthException.dart';
import 'package:caronas/services/auth_service.dart';
import 'package:caronas/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    final loading = ValueNotifier<bool>(false);

    void logIn() async {
      if (_formKey.currentState!.validate()) {
        loading.value = true;
        String email = _emailController.text;
        String password = _passwordController.text;
        try {
          await authService.signIn(email, password);
          loading.value = false;
        } catch (error) {
          if (error is AuthException) {
            CustomSnackBar.showSnackBar(
              context,
              error.message,
              Colors.red,
              Colors.white,
            );
          }
        }
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
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
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      hintText: 'example@example.com',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'E-mail is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Container(
                      color: Colors.white,
                      child: ElevatedButton(
                        onPressed: logIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: AnimatedBuilder(
                            animation: loading,
                            builder: (context, _) {
                              return loading.value
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Log In',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.NEWACCOUNT);
                    },
                    child: const Text(
                      'Create new account',
                      style: TextStyle(fontSize: 14, color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
