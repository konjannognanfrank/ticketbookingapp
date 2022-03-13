import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myuiapp/pages/auth/signup.dart';
import 'package:myuiapp/pages/homepage.dart';
import 'package:myuiapp/widgets/bottomNav.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  static final routeName = '/login-screen';
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  _signinWithEmailPassword() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final UserCredential _user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      setState(() {
        Fluttertoast.showToast(msg: 'Login Successfully');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => BottomNav()));
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Login",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Signup()));
              },
              icon: Icon(
                Icons.app_registration,
                color: Colors.black,
              )),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Signup()));
                },
                child: Text(
                  "Signup",
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
                'assets/login.png',
                height: 300,
              )),
          Form(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                key: _formKey,
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      focusColor: Color.fromRGBO(100, 0, 100, 10),
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: _passwordController,
                    obscureText: true,
                    onFieldSubmitted: (_) {
                      _signinWithEmailPassword();
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      focusColor: Color.fromRGBO(100, 0, 100, 10),
                      hintText: "Password",
                      prefixIcon: Icon(Icons.password_outlined),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      _signinWithEmailPassword();
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
                          "Login",
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
