import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:caronas/models/user.dart';
import 'package:caronas/data/login_data.dart';
import 'dart:io';
import 'package:intl/intl.dart';

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
  String _selectedGender = 'Masculino';

  XFile? _imageFile;

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    _birthdateController.addListener(_formatBirthdate);
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

  void _registerUser() {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;
      String email = _emailController.text;
      String birthdate = _birthdateController.text;
      String gender = _selectedGender;

      User newUser = User(
        id: UniqueKey().toString(),
        email: email,
        birth: _dateFormat.parse(birthdate),
        gender: gender,
        name: username,
        password: password,
        image: _imageFile != null ? File(_imageFile!.path) : null,
        rating: 0.0,
      );

      setState(() {
        loginData.add(newUser);

        _usernameController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
        _emailController.clear();
        _birthdateController.clear();
        _selectedGender = 'Masculino';
        _imageFile = null;
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('User registered successfully!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title:
            Text('Login registration', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey, // Associar a chave do formulário
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
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
                    decoration: InputDecoration(
                        labelText: 'E-mail', hintText: 'example@example.com'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'E-mail is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
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
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
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
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _birthdateController,
                    decoration: InputDecoration(
                      labelText: 'Birth date',
                      hintText: 'MM/DD/AAAA',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    value: _selectedGender,
                    items: ['Masculino', 'Feminino', 'Outro'].map((gender) {
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
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Container(
                      width: double.infinity,
                      child: Center(
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
                        : Placeholder(),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Container(
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
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
