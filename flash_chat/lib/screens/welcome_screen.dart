import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/customWidgets/round_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  final bool? isLoggedIn;
  const WelcomeScreen({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

pushAndRemoveUntil(BuildContext context, Widget destination, bool predict) {
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => destination), (Route<dynamic> route) => predict);
}


class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {

    if (widget.isLoggedIn ?? false) {
      Future.delayed(const Duration(seconds: 2),(){
        pushAndRemoveUntil(context, const ChatScreen(), false);
      });

    }


    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      upperBound: 1,
    );

    // animation = CurvedAnimation(parent: controller!, curve: Curves.easeIn);

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white).animate(controller!);

    controller?.forward();

    // animation?.addStatusListener((status) {
    //   if (status == AnimationStatus.dismissed) {
    //     controller?.forward();
    //   }
    // });
    controller?.addListener(() {
      setState(() {});

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation?.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText("Flash Chat",
                        textStyle: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.black54
                        ),speed: Duration(milliseconds: 100)
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Button(
              buttonText: "Login",
              onPressed: () {
                pushAndRemoveUntil(context, const LoginScreen(), false);
              },
            ),
            Button(
              buttonText: "Register",
              onPressed: () {
                pushAndRemoveUntil(context, const RegistrationScreen(), false);
              },
            )
          ],
        ),
      ),
    );
  }
}
