import 'dart:io';

import 'package:caronas/components/snackbar.dart';
import 'package:caronas/errors/AuthException.dart';
import 'package:caronas/models/app_user.dart';
import 'package:caronas/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CadastroLogin extends StatefulWidget {
  @override
  _CadastroLoginState createState() => _CadastroLoginState();
}

class _CadastroLoginState extends State<CadastroLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  String _selectedGender = 'Male';
  XFile? _imageFile;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final _formKey = GlobalKey<FormState>();
  final loading = ValueNotifier<bool>(false);

  void initState() {
    super.initState();
    _birthdateController.addListener(_formatBirthdate);
  }

  void resetInputs() {
    setState(() {
      _usernameController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      _emailController.clear();
      _birthdateController.clear();
      _selectedGender = 'Male';
      _imageFile = null;
    });
  }

  void _formatBirthdate() {
    final text = _birthdateController.text;
    if (text.isNotEmpty && text.length == 2) {
      _birthdateController.text = '$text/';
      _birthdateController.selection = TextSelection.fromPosition(
        TextPosition(offset: _birthdateController.text.length),
      );
    } else if (text.isNotEmpty && text.length == 5) {
      _birthdateController.text = '$text/';
      _birthdateController.selection = TextSelection.fromPosition(
        TextPosition(offset: _birthdateController.text.length),
      );
    }
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context, listen: false);

    void registerUser() async {
      if (_formKey.currentState!.validate()) {
        loading.value = true;
        String username = _usernameController.text;
        String password = _passwordController.text;
        String email = _emailController.text;
        String birthdate = _birthdateController.text;
        String gender = _selectedGender;

        AppUser newUser = AppUser(
          id: UniqueKey().toString(),
          email: email,
          birth: _dateFormat.parse(birthdate),
          gender: gender,
          name: username,
          password: password,
          image: '',
          rating: 0.0,
          car: null,
        );
        try {
          await authService.createUser(newUser, _imageFile);
          CustomSnackBar.showSnackBar(
            context,
            "User created successfuly",
            Colors.green,
            Colors.white,
          );
          resetInputs();
          Navigator.of(context).pop();
        } catch (error) {
          if (error is AuthException) {
            CustomSnackBar.showSnackBar(
              context,
              error.message,
              Colors.red,
              Colors.white,
            );
          } else {
            CustomSnackBar.showSnackBar(
              context,
              "Internal server error",
              Colors.red,
              Colors.white,
            );
          }
        }
        loading.value = false;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Login registration',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        labelText: 'E-mail', hintText: 'example@example.com'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'E-mail is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm password is required';
                      }
                      if (value != _passwordController.text) {
                        return 'Password and Confirm password must be equals';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _birthdateController,
                    decoration: const InputDecoration(
                      labelText: 'Birth date',
                      hintText: 'MM/DD/YYYY',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    value: _selectedGender,
                    items: ['Male', 'Female', 'Other'].map((gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value.toString();
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Gender is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Container(
                      width: double.infinity,
                      child: const Center(
                          child: Text(
                        'Select image',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                    ),
                  ),
                  Container(
                    height: 152,
                    width: 152,
                    child: _imageFile != null
                        ? Image.file(File(_imageFile!.path), fit: BoxFit.cover)
                        : const Placeholder(),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Container(
                      width: double.infinity,
                      child: Center(
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
                                    'Register',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  );
                          },
                        ),
                      ),
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
