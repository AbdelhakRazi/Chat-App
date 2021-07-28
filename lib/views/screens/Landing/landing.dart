import 'package:chat_app/config/colors.dart';
import 'package:chat_app/views/routes/routes.dart';
import 'package:chat_app/views/routes/routes_names.dart';
import 'package:chat_app/views/screens/authPages/Login..dart';
import 'package:chat_app/views/screens/authPages/SignUp.dart';
import 'package:chat_app/views/screens/authPages/components/AuthButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: scheight * 0.15),
          AspectRatio(
              aspectRatio: 3 / 2,
              child: SvgPicture.asset("assets/landing.svg")),
          SizedBox(height: scheight * 0.03),
          Flexible(
            child: Center(
                child: Text("Chat App",
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontSize: 35))),
          ),
          SizedBox(height: scheight * 0.01),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          ),
          SizedBox(height: scheight * 0.03),
          Flexible(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 20, left: 150),
                  child: AuthButton(
                      factor: 0.6,
                      text: "Sign Up",
                      scheight: scheight,
                      color: AppColors.butcolor,
                      textcolor: AppColors.white,
                      func: () {
                        return Navigator.push(
                            context,
                            Routes.onGenerateRoute(
                                RouteSettings(name: AppRoutes.signup)));
                      }),
                ),
                Container(
                  padding: EdgeInsets.only(right: 170, left: 20),
                  child: AuthButton(
                    text: "Login",
                    factor: 0.6,
                    scheight: scheight,
                    func: () => Navigator.push(
                        context,
                        Routes.onGenerateRoute(
                            RouteSettings(name: AppRoutes.login))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
