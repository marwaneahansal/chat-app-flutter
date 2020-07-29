import 'package:chat_app/Widgets/widgets.dart';
import 'package:chat_app/services/auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  AuthMethods authMethods = new AuthMethods();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  signUpBtn() {
    if (formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });

      authMethods
          .signUp(emailController.text, passwordController.text)
          .then((value) => print(value));
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
                      GestureDetector(
                        onTap: () {
                          return this.signUpBtn();
                        },
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
                            'Sign Up',
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
            ),
    );
  }
}
