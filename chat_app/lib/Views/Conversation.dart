import 'package:chat_app/helper/authenticate.dart';
import 'package:chat_app/helper/dataFunctions.dart';
import 'package:chat_app/helper/userData.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/Views/searchUser.dart';
import 'package:chat_app/services/db.dart';
import 'package:flutter/material.dart';

class Conversation extends StatefulWidget {
  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  AuthMethods authMethods = new AuthMethods();
  DataFunctions dataFunctions = new DataFunctions();
  DbMethods dbMethods = new DbMethods();
  Stream allConversation;

  Widget conversationList() {
    return StreamBuilder(
      stream: allConversation,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return ConversationTile(snapshot
                  .data.documents[index].data['conversationId']
                  .toString()
                  .replaceAll("_", "")
                  .replaceAll(UserData.myUsername, ""));
            },
          );
        } else
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
      },
    );
  }

  @override
  void initState() {
    getUserInfo();

    super.initState();
  }

  getUserInfo() async {
    UserData.myUsername = await dataFunctions.getUsername();
    dbMethods.getAllCoversation(UserData.myUsername).then((value) {
      setState(() {
        allConversation = value;
      });
    });
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
      body: conversationList(),
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

class ConversationTile extends StatelessWidget {
  final String username;
  ConversationTile(this.username);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Text(
              username,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          SizedBox(
            width: 8,
          )
        ],
      ),
    );
  }
}
