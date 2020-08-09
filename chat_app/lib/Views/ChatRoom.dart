import 'package:chat_app/Widgets/widgets.dart';
import 'package:chat_app/helper/userData.dart';
import 'package:chat_app/services/db.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  final String conversationId;

  ChatRoom(this.conversationId);
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController newMessage = new TextEditingController();
  DbMethods dbMethods = new DbMethods();
  Stream chatMessages;
  bool loading = false;

  Widget messageList() {
    return StreamBuilder(
      stream: chatMessages,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return Message(
                  snapshot.data.documents[index].data["message"],
                  snapshot.data.documents[index].data["sendBy"] ==
                      UserData.myUsername);
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

  void sendMessage() {
    if (newMessage.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "message": newMessage.text,
        "sendBy": UserData.myUsername,
        "createdAt": DateTime.now(),
      };
      dbMethods.addConversationMessages(widget.conversationId, messages);
      newMessage.text = "";
    }
  }

  @override
  void initState() {
    dbMethods.getConversationMessages(widget.conversationId).then((value) {
      setState(() {
        chatMessages = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: <Widget>[
            messageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0X45FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      controller: newMessage,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Message",
                        hintStyle: TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
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
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message extends StatelessWidget {
  final String message;
  final bool isSentByMe;
  Message(this.message, this.isSentByMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSentByMe
                ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                : [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)],
          ),
          borderRadius: isSentByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
