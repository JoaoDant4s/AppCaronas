import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CadastroLogin extends StatefulWidget {
  @override
  _CadastroLoginState createState() => _CadastroLoginState();
}

class _CadastroLoginState extends State<CadastroLogin> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  XFile? _imageFile;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = pickedImage;
      });
    }
  }

  bool _validateForm() {
    if (_usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        _birthdateController.text.isEmpty ||
        _genderController.text.isEmpty) {
      return false;
    } else if (_passwordController.text != _confirmPasswordController.text) {
      return false;
    }
    return true;
  }

  void _registerUser() {
    if (_validateForm()) {


      String username = _usernameController.text;
      String password = _passwordController.text;
      String birthdate = _birthdateController.text;
      String gender = _genderController.text;



      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Sucesso'),
            content: Text('Cadastro de login realizado com sucesso!'),
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
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Por favor, preencha todos os campos corretamente.'),
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
        title: Text('Login registration', style: TextStyle(color: Colors.white)),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                SizedBox(height: 20.0),

                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(height: 20.0),

                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Confirm password'),
                ),
                SizedBox(height: 20.0),

                TextField(
                  controller: _birthdateController,
                  decoration: InputDecoration(labelText: 'Data de Nascimento'),
                ),
                SizedBox(height: 20.0),

                TextField(
                  controller: _genderController,
                  decoration: InputDecoration(labelText: 'Gênero'),
                ),
                SizedBox(height: 20.0),

                ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Container(
                    width: double.infinity,
                    child: Center(child: Text('Escolher Imagem',style: TextStyle(color: Colors.white,fontSize: 20),)),
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
                    child: Center(child: Text('Register',style: TextStyle(color: Colors.white,fontSize: 20),)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}