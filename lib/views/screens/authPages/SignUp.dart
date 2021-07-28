import 'package:chat_app/AuthManagment/Auth.dart';
import 'package:chat_app/config/colors.dart';
import 'package:chat_app/config/icons.dart';
import 'package:chat_app/views/routes/routes.dart';
import 'package:chat_app/views/routes/routes_names.dart';
import 'package:chat_app/views/screens/Landing/ChooseScreen.dart';
import 'package:chat_app/views/screens/authPages/components/AuthButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  final TextEditingController emailctl = TextEditingController();
  final TextEditingController passwordctl = TextEditingController();
  final TextEditingController confirmctl = TextEditingController();
  final TextEditingController namectl = TextEditingController();
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Auth _auth = new Auth();
  final _formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    final scheight = MediaQuery.of(context).size.height;
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
                "Let's get\nstarted",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: scheight * 0.1),
              Form(
                key: _formkey,
                child: Container(
                  height: scheight,
                  child: Column(
                    children: [
                      buildTextFormFieldname(context),
                      SizedBox(
                        height: scheight * 0.03,
                      ),
                      buildTextFormFieldemail(context),
                      SizedBox(
                        height: scheight * 0.03,
                      ),
                      buildTextFormFieldpassword(context),
                      SizedBox(
                        height: scheight * 0.03,
                      ),
                      buildTextFormFieldconfirm(context),
                      SizedBox(
                        height: scheight * 0.05,
                      ),
                      Flexible(
                        child: AuthButton(
                            text: "Create an account",
                            factor: 0.14,
                            func: () async {
                              if (_formkey.currentState.validate()) {
                                dynamic result = await _auth.createAccount(
                                    widget.emailctl.text,
                                    widget.passwordctl.text,
                                    widget.namectl.text);
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
                                    RouteSettings(name: AppRoutes.login)));
                          },
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Already have an account?",
                                  style: Theme.of(context).textTheme.bodyText1),
                              TextSpan(
                                  text: " Login",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(color: AppColors.white)),
                            ]),
                          )),
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

  TextFormField buildTextFormFieldname(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.white,
      style: Theme.of(context).textTheme.bodyText2,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter a name";
        } else {
          if (value.length < 3) {
            return "Name should have at least 3 characters";
          }
        }
      },
      controller: widget.namectl,
      decoration: InputDecoration(hintText: "Name", prefixIcon: AppIcons.nme),
    );
  }

  TextFormField buildTextFormFieldconfirm(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.white,
      style: Theme.of(context).textTheme.bodyText2,
      obscureText: true,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter a password";
        } else {
          if (value != widget.passwordctl.text) {
            return "No match in passwords";
          }
        }
      },
      controller: widget.confirmctl,
      decoration: InputDecoration(
          hintText: "Confirm Password", prefixIcon: AppIcons.pass),
    );
  }

  TextFormField buildTextFormFieldpassword(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.white,
      style: Theme.of(context).textTheme.bodyText2,
      obscureText: true,
      controller: widget.passwordctl,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter a password";
        } else {
          if (value.length < 6) {
            return "Password too short";
          }
        }
      },
      decoration:
          InputDecoration(hintText: "Password", prefixIcon: AppIcons.pass),
    );
  }

  TextFormField buildTextFormFieldemail(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.white,
      style: Theme.of(context).textTheme.bodyText2,
      controller: widget.emailctl,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
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
      decoration:
          InputDecoration(hintText: "Email", prefixIcon: AppIcons.email),
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
}
