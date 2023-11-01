import 'package:caronas/components/snackbar.dart';
import 'package:caronas/models/app_user.dart';
import 'package:caronas/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  final AppUser user;

  MyProfile(this.user);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  XFile? _imageFile;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final _formkey = GlobalKey<FormState>();
  final loading = ValueNotifier<bool>(false);

  @override
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

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context, listen: true);
    _usernameController.text = authService.user!.name;
    _emailController.text = authService.user!.email;
    _birthdateController.text =
        "${authService.user!.birth.day.toString()}/${authService.user!.birth.month}/${authService.user!.birth.year.toString()}";
    String _selectedGender = authService.user!.gender;

    void updateUser() async {
      if (_formkey.currentState!.validate()) {
        loading.value = true;
        authService.user!.setName(_usernameController.text);
        authService.user!.setGender(_selectedGender);
        authService.user!
            .setBirth(_dateFormat.parse(_birthdateController.text));
        try {
          await authService.updateUser(authService.user!);
          CustomSnackBar.showSnackBar(
            context,
            "User updated successfuly",
            Colors.green,
            Colors.white,
          );
        } catch (e) {
          CustomSnackBar.showSnackBar(
            context,
            "Error updating user data",
            Colors.red,
            Colors.white,
          );
        }

        loading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF09C184),
        title: const Text(
          'My profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: ClipOval(
                        child: authService.user!.image.isNotEmpty
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    Image.network(authService.user!.image)
                                        .image,
                              )
                            : const CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey,
                                child: Icon(
                                  CupertinoIcons.person_fill,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 25,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          authService.user!.rating.toString(),
                          style: const TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
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
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailController,
                      readOnly: true,
                      enabled: false,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(219, 217, 217, 1),
                        labelText: 'E-mail',
                        hintText: 'example@example.com',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(99, 99, 99, 1),
                          ),
                        ),
                      ),
                      style:
                          const TextStyle(color: Color.fromRGBO(99, 99, 99, 1)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: DropdownButtonFormField(
                            value: _selectedGender,
                            decoration: const InputDecoration(
                              labelText: 'Gender',
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
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            controller: _birthdateController,
                            decoration: const InputDecoration(
                              labelText: 'Birth date',
                              hintText: 'MM/DD/YYYY',
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
                                return 'Birth date is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: updateUser,
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
          ],
        ),
      ),
    );
  }
}
