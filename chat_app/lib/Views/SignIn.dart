import 'package:chat_app/Views/Conversation.dart';
import 'package:chat_app/Widgets/widgets.dart';
import 'package:chat_app/helper/dataFunctions.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading = false;
  QuerySnapshot userInfo;
  String errorText = "";
  AuthMethods authMethods = new AuthMethods();
  DbMethods dbMethods = new DbMethods();
  DataFunctions dataFunctions = new DataFunctions();

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  signInBtn() {
    if (formKey.currentState.validate()) {
      dataFunctions.saveEmail(emailController.text.trim());

      dbMethods.getUserByEmail(emailController.text.trim()).then((user) {
        userInfo = user;
        dataFunctions.saveUsername(userInfo.documents[0].data['username']);
      });

      setState(() {
        loading = true;
      });

      authMethods
          .signIn(emailController.text.trim(), passwordController.text.trim())
          .then((value) {
        if (value != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Conversation(),
              ));
        } else {
          setState(() {
            loading = false;
            errorText = "Email OR Password is wrong!!";
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
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
                      Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: (value) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)
                                    ? null
                                    : "Valid email is required!";
                              },
                              controller: emailController,
                              decoration: textFieldInputDecorator('Email'),
                              style: textStyleField(),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (value) {
                                return value.length > 6
                                    ? null
                                    : "Password must be at least 6 characters";
                              },
                              controller: passwordController,
                              decoration: textFieldInputDecorator('Password'),
                              style: textStyleField(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Text(
                        errorText,
                        style: TextStyle(color: Colors.red),
                      ),
                      GestureDetector(
                        onTap: () => signInBtn(),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xff007EF4),
                                const Color(0xff2A75BC)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
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
                            "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.white54,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggle();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'Register now',
                                style: TextStyle(
                                  color: Colors.white54,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
