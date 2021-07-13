import 'package:Agriculture/auth.dart';
import 'package:Agriculture/authenticate.dart';
import 'package:Agriculture/constant.dart';
import 'package:Agriculture/conversation_screen.dart';
import 'package:Agriculture/database.dart';
import 'package:Agriculture/helperfunction.dart';
import 'package:Agriculture/search.dart';
import 'package:Agriculture/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  ChatRoomState createState() => ChatRoomState();
}

class ChatRoomState extends State<ChatRoom> {
  AuthMethod authMethod = new AuthMethod();
  Function toggle;

  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatRoomStream;
  getChatRoom() {
    return StreamBuilder(
        stream: chatRoomStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return ChatRoomTile(
                        snapshot.data.documents[index].data["chatRoomId"]
                            .toString()
                            .replaceAll("_", "")
                            .replaceAll(Constant.myName, ""),
                        snapshot.data.documents[index].data["chatRoomId"]);
                  })
              : Container();
        });
  }

  initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constant.myName = await HelperFunctions.getUserNameSharedPreference();
    databaseMethods.getChatRoom(Constant.myName).then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App, By Kelvin C7'),
        actions: [
          GestureDetector(
            onTap: () {
              HelperFunctions.removeUserEmailSharedPreference();
              authMethod.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return Signin(toggle);
                }),
              );
            },
            child: Container(
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      body: getChatRoom(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Search(),
            ),
          );
        },
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomTile(this.userName, this.chatRoomId);
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationScreen(chatRoomId),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: Color(0xFF90CAF9),
        margin: EdgeInsets.only(bottom: 1),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              child: Text(
                "${userName.substring(0, 1).toUpperCase()}",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(colors: [
                  const Color(0xFF1565C0),
                  const Color(0xFF2196F3),
                ]),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              userName,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
