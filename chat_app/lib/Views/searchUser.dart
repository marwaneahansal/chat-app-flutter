import 'package:chat_app/Widgets/widgets.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController emailSearch = new TextEditingController();
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
                      controller: emailSearch,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search email",
                        hintStyle: TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                    )),
                    Container(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
