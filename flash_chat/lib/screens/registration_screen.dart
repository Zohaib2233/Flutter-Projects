import 'package:flutter/material.dart';
import 'package:flash_chat/customWidgets/text_field.dart';
import 'package:flash_chat/customWidgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                SizedBox(
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
                InputField(
                  onChanged: (value){
                    email = value;

                  },
                  isPassword: false,
                  hintText: "Enter Your Email",
                ),
                const SizedBox(
                  height: 8,
                ),
                InputField(hintText: "Enter Password",
                isPassword: true,
                onChanged: (value){
                        password = value;

                },),
                SizedBox(
                  height: 24,
                ),
                Button(buttonText: "Register",
                    onPressed: () async{
                  setState(() {
                    showSpinner=true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email!, password: password!);
                    print(newUser);
                    setState(() {
                      showSpinner = false;
                    });
                    Navigator.pushNamed(context, 'chat_screen');

                  }
                  catch(e){
                    print(e);
                  }

                }
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
