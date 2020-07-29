import 'package:chat_app/Widgets/widgets.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 230,
                child: Image(
                  image: AssetImage('assets/images/signIn_chat.png'),
                ),
              ),
              TextField(
                decoration: textFieldInputDecorator('Email'),
                style: textStyleField(),
              ),
              TextField(
                decoration: textFieldInputDecorator('Password'),
                style: textStyleField(),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xff007EF4), const Color(0xff2A75BC)],
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                  Text(
                    'sign in now',
                    style: TextStyle(
                      color: Colors.white54,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
