import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';


final _firestore = FirebaseFirestore.instance;
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();
  String? messageText;

  User? loggedInUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }


  void getCurrentUser()async{
    try{
      final user  = _auth.currentUser;
      print(user?.email);
      if(user !=null){
        loggedInUser = user;

      }

    }
    catch(e){
      print(e);
    }}

  void getMessages()async{
    await for(var snapshot in _firestore.collection('messages').snapshots()){
      for (var message in snapshot.docs){
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async{
                getMessages();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('isLoggedIn');
                _auth.signOut();
                Navigator.pushReplacementNamed(context, 'login_screen');

              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {

                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _firestore.collection("messages").add({
                        'sender': loggedInUser!.email,
                        'text': messageText
                      });
                      print("$messageText ${loggedInUser!.email}");
                      messageTextController.clear(); 
                      //Implement send functionality.
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot){
        List<MessageBubble> messageWidgets =[];
        if (!snapshot.hasData){
          return const CircularProgressIndicator();
        }
        final messages = snapshot.data?.docs;

        for (var message in messages!){
          final messageText = message.get('text');
          final senderText = message.get('sender');

          final messageWidget = MessageBubble(messageText: messageText,
            senderText: senderText,);
          messageWidgets.add(messageWidget);
        }

        return Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
                horizontal: 10,vertical: 20
            ),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}


class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key,
    required this.senderText,required this.messageText}) : super(key: key);

  final String messageText;
  final String senderText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(senderText,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54
          ),),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(30),
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text(messageText,
                style: TextStyle(
                    fontSize: 15,
                  color: Colors.white
                ),),
            ),
          ),
        ],
      ),
    );;
  }
}

