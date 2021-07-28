import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  String text;
  double factor;
  double scheight;
  Color color;
  Color textcolor;
  Function func;
  AuthButton(
      {this.text,
      this.factor,
      this.scheight,
      this.color,
      this.textcolor,
      this.func});
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: factor,
      child: RaisedButton(
        color: color,
        child: text == "Sign Up"
            ? Align(
                alignment: Alignment(0.7, 0),
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: textcolor),
                ))
            : Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: textcolor),
              ),
        onPressed: func,
      ),
    );
  }
}
