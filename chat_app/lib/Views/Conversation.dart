import 'package:chat_app/helper/authenticate.dart';
import 'package:chat_app/helper/dataFunctions.dart';
import 'package:chat_app/helper/userData.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/Views/searchUser.dart';
import 'package:flutter/material.dart';

class Conversation extends StatefulWidget {
  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  AuthMethods authMethods = new AuthMethods();
  DataFunctions dataFunctions = new DataFunctions();
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    UserData.myUsername = await dataFunctions.getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },
      ),
    );
  }
}
