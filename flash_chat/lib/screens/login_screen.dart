import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/customWidgets/text_field.dart';
import 'package:flash_chat/customWidgets/round_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                InputField(hintText: "Enter Your Email",
                isPassword: false,
                onChanged: (value){
                        email = value;
                },),
                const SizedBox(
                  height: 8,
                ),
                InputField(hintText: "Enter Password",
                isPassword: true,
                onChanged: (value){
                  password = value;

                },
                ),
                const SizedBox(
                  height: 24,
                ),
              Button(buttonText:"Login",
                  onPressed:()async{
                    setState(() {
                      showSpinner=true;
                    });
                    try{
                      final logIn = await _auth.signInWithEmailAndPassword(email: email!, password: password!);
                      print(logIn);
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', true);
                      Navigator.pushReplacementNamed(context, 'chat_screen');
                      setState(() {
                        showSpinner=false;
                      });

                    }
                    on FirebaseException catch(e){
                      Fluttertoast.showToast(msg: e.code,
                      toastLength: Toast.LENGTH_LONG);
                      setState(() {
                        showSpinner=false;
                      });
                      print(e.code);
                    }

                  }),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't Have Account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()));
                        },
                        child: Text("Register"))
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}




