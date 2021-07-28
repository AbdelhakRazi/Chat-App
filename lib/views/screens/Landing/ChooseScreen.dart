import 'package:chat_app/AuthManagment/Auth.dart';
import 'package:chat_app/views/screens/ChatScreens/ChatScreen.dart';
import 'package:chat_app/views/screens/ChatScreens/SearchScreen.dart';
import 'package:chat_app/views/screens/Landing/landing.dart';
import 'package:chat_app/views/screens/authPages/Login..dart';
import 'package:chat_app/views/screens/authPages/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseScreen extends StatelessWidget {
  @override
  ChooseScreen({this.landing});
  bool landing;
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      if (landing == true) {
        return Landing();
      } else {
        return Login();
      }
    } else {
      return SearchScreen();
    }
  }
}
