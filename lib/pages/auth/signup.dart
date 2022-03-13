import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myuiapp/pages/auth/login.dart';
import 'package:myuiapp/pages/homepage.dart';

import '../../widgets/bottomNav.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _fullNameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _confirmPasswordController = TextEditingController();

  TextEditingController _contactController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  void _registerWithEmailPassword() async {
    String _email = _emailController.text.trim();
    String _password = _passwordController.text.trim();
    String _confirmPassword = _confirmPasswordController.text.trim();
    if (_password == _confirmPassword) {
      try {
        final UserCredential _userCredidential = await _auth
            .createUserWithEmailAndPassword(email: _email, password: _password);
        setState(() {
          if (_userCredidential != null) {
            Fluttertoast.showToast(msg: 'Account created successfully');
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Login()));
          }
        });
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    } else {
      Fluttertoast.showToast(msg: 'Passwords do not match');
    }
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Login()));
          },
          child: Text(
            "Signup",
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Login()));
              },
              icon: Icon(
                Icons.login_outlined,
                color: Colors.black,
              )),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Center(
              child: InkWell(
                onTap: () {},
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: Image.asset(
              'assets/signup.png',
              height: 300,
            ),
          ),
          Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    key: _formKey,
                    children: [
                      Container(
                        height: 10,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          focusColor: Color.fromRGBO(100, 0, 100, 10),
                          hintText: "Email Address",
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                        },
                      ),
                      Container(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          focusColor: Color.fromRGBO(100, 0, 100, 10),
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password_outlined),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This Field is Required";
                          } else if (value.isNotEmpty && value.length < 6) {
                            return "password is too short";
                          } else {
                            return null;
                          }
                        },
                      ),
                      Container(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          focusColor: Color.fromRGBO(100, 0, 100, 10),
                          hintText: "Confirm Password",
                          prefixIcon: Icon(Icons.password_outlined),
                        ),
                        onFieldSubmitted: (_) {
                          _registerWithEmailPassword();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This Field is Required";
                          } else if (_passwordController.text !=
                              _confirmPasswordController.text) {
                            return "Passwords do not match";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          _registerWithEmailPassword();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 17,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 20,
                          ),
                          Text(
                            "Forgot Password?",
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
