import 'package:chat_app/AuthManagment/Auth.dart';
import 'package:chat_app/config/colors.dart';
import 'package:chat_app/config/icons.dart';
import 'package:chat_app/views/routes/routes.dart';
import 'package:chat_app/views/routes/routes_names.dart';
import 'package:chat_app/views/screens/authPages/components/AuthButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  final TextEditingController emailctl = TextEditingController();
  final TextEditingController passwordctl = TextEditingController();
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  final _formkey = new GlobalKey<FormState>();
  Auth _auth = new Auth();

  Widget build(BuildContext context) {
    final scheight = MediaQuery.of(context).size.height;
    void dispose() {
      widget.emailctl.dispose();
      widget.passwordctl.dispose();
      super.dispose();
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Container(
        height: scheight,
        width: double.infinity,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hey,\nWelcome\nBack!",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: scheight * 0.1),
              Form(
                key: _formkey,
                child: Container(
                  height: scheight,
                  child: Column(
                    children: [
                      buildTextFormFieldemail(context),
                      SizedBox(
                        height: scheight * 0.03,
                      ),
                      buildTextFormFieldpassword(context),
                      SizedBox(
                        height: scheight * 0.03,
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: Text("Forgot Password?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 16))),
                      SizedBox(
                        height: scheight * 0.03,
                      ),
                      Flexible(
                        child: AuthButton(
                            factor: 0.14,
                            text: "Login",
                            func: () async {
                              if (_formkey.currentState.validate()) {
                                dynamic result = await _auth.signIn(
                                    widget.emailctl.text,
                                    widget.passwordctl.text);
                                if (result != null) {
                                  if (result is FirebaseAuthException) {
                                    showDialog(
                                        context: context,
                                        child:
                                            buildAlertDialog(result, context));
                                  } else {
                                    Navigator.pop(context);
                                  }
                                }
                              }
                            }),
                      ),
                      SizedBox(
                        height: scheight * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              Routes.onGenerateRoute(
                                  RouteSettings(name: AppRoutes.signup)));
                        },
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Don't have an account?",
                                style: Theme.of(context).textTheme.bodyText1),
                            TextSpan(
                                text: "Sign up",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: AppColors.white)),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AlertDialog buildAlertDialog(
      FirebaseAuthException result, BuildContext context) {
    return AlertDialog(
      content: Text(
        result.message,
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: AppColors.backgrd),
      ),
    );
  }

  TextFormField buildTextFormFieldemail(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      enabled: true,
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter an email";
        }
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }
      },
      cursorColor: AppColors.white,
      style: Theme.of(context).textTheme.bodyText2,
      controller: widget.emailctl,
      decoration:
          InputDecoration(hintText: "Email", prefixIcon: AppIcons.email),
    );
  }

  TextFormField buildTextFormFieldpassword(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.white,
      obscureText: true,
      style: Theme.of(context).textTheme.bodyText2,
      controller: widget.passwordctl,
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter a password";
        } else {
          if (value.length < 6) {
            return "Password too short";
          }
        }
      },
      keyboardType: TextInputType.visiblePassword,
      decoration:
          InputDecoration(hintText: "Password", prefixIcon: AppIcons.pass),
    );
  }
}
