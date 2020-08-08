import 'package:chat_app/Views/ChatRoom.dart';
import 'package:chat_app/Widgets/widgets.dart';
import 'package:chat_app/helper/dataFunctions.dart';
import 'package:chat_app/helper/userData.dart';
import 'package:chat_app/services/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController usernameSearch = new TextEditingController();
  DbMethods dbMethods = new DbMethods();
  DataFunctions dataFunctions = new DataFunctions();
  QuerySnapshot userSearch;

  getUsers() {
    dbMethods.getUserByUsername(usernameSearch.text.trim()).then((value) {
      setState(() {
        userSearch = value;
      });
    });
  }

  Widget userList() {
    return userSearch != null
        ? ListView.builder(
            itemCount: userSearch.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return UserSearchLabel(
                userEmail: userSearch.documents[0].data["email"],
                username: userSearch.documents[0].data["username"],
              );
            })
        : Container();
  }

  startConversation(BuildContext context, String username) {
    List<String> chatUsers = [username, UserData.myUsername];
    Map<String, dynamic> conversation = {
      "users": chatUsers,
      "conversationId": getConversationId(username, UserData.myUsername)
    };

    dbMethods.createConversation(conversation);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChatRoom()));
  }

  getConversationId(String userOne, String userTwo) {
    if (userOne.substring(0, 1).codeUnitAt(0) >
        userTwo.substring(0, 1).codeUnitAt(0)) {
      return "$userTwo\_$userOne";
    } else {
      return "$userOne\_$userTwo";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                color: Color(0X45FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      controller: usernameSearch,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search username",
                        hintStyle: TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        getUsers();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Image.asset("assets/images/search-64.png"),
                      ),
                    ),
                  ],
                ),
              ),
              userList(),
            ],
          ),
        ),
      ),
    );
  }
}

class UserSearchLabel extends StatelessWidget {
  final String username;
  final String userEmail;

  UserSearchLabel({this.userEmail, this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                username,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                userEmail,
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              _SearchState().startConversation(context, username);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Message',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
