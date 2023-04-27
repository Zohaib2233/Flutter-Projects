import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isLoggedIn = prefs.getBool('isLoggedIn');
  await Firebase.initializeApp();
  runApp(MyApp(isLoggedIn: isLoggedIn,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,
  required this.isLoggedIn});

  final bool? isLoggedIn;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen' : (context) => WelcomeScreen(isLoggedIn: isLoggedIn,),
        'login_screen' : (context) =>const LoginScreen(),
        'registration_screen' : (context) =>const RegistrationScreen(),
        'chat_screen' : (context) =>const ChatScreen(),
      },
      // home: const WelcomeScreen(),
    );
  }
}


