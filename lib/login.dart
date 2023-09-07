// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sales/global.dart';
import 'package:sales/homeAdmin.dart';
import 'package:sales/main.dart';
import 'package:sales/models/apis.dart';
import 'package:sales/themes/colors.dart';

bool hidePass = true;
final TextEditingController controllerUsername = TextEditingController();
final TextEditingController controllerPassword = TextEditingController();

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var berhasiLogin = false;
  ServicesUser servicesUser = ServicesUser();

  @override
  void initState() {
    super.initState();
  }

  void clear() {
    controllerUsername.clear();
    controllerPassword.clear();
  }

  void dispose() {
    controllerUsername.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  Future getAuth(username, password) async {
    var response = await servicesUser.getAuth(username, password);
    if (response[0] != 404) {
      idUser = response[1]['id_user'].toString();
      NamaUser = response[1]['nama_user'].toString();
      return true;
    } else {
      return false;
    }
  }

  Future getAuthAdmin(username, password) async {
    var response = await servicesUser.getAuthAdmin(username, password);
    if (response[0] != 404) {
      idUser = response[1]['id_user'].toString();
      NamaUser = response[1]['nama_user'].toString();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navbar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(
                      Icons.lock_open,
                      size: 60.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          color: darkText,
                          fontSize: 45,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      controller: controllerUsername,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.people),
                        prefixIconColor: navbar,
                        hintText: ' Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                      controller: controllerPassword,
                      obscureText: hidePass,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.lock),
                        prefixIconColor: navbar,
                        hintText: ' Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePass = !hidePass;
                            });
                          },
                          icon: hidePass == false
                              ? Icon(Icons.remove_red_eye_outlined)
                              : Icon(Icons.visibility_off_outlined),
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              getAuth(controllerUsername.text,
                                      controllerPassword.text)
                                  .then((value) {
                                if (value) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomePage(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Username/password Salah")));
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 18),
                              backgroundColor: lightText,
                              side: BorderSide(
                                color: lightText,
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Login as Sales",
                              style: GoogleFonts.inter(
                                color: darkText,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              getAuthAdmin(controllerUsername.text,
                                      controllerPassword.text)
                                  .then((value) {
                                if (value) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomeAdmin(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Username/password Salah")));
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 18),
                              backgroundColor: lightText,
                              side: BorderSide(
                                color: lightText,
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Login as Admin",
                              style: GoogleFonts.inter(
                                color: darkText,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
