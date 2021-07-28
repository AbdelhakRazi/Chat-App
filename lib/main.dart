import 'package:chat_app/AuthManagment/Auth.dart';
import 'package:chat_app/config/theme.dart';
import 'package:chat_app/views/screens/ChatScreens/ChatScreen.dart';
import 'package:chat_app/views/screens/Landing/ChooseScreen.dart';
import 'package:chat_app/views/screens/Landing/landing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Auth _auth = new Auth();
  bool _landing = true;
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: _auth.listeauth,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.defaultTheme,
          home: ChooseScreen(
            landing: _landing,
          ),
        ));
  }
}
