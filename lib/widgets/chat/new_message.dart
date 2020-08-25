import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';

  final _controllerText = TextEditingController();

  void _sendMesage() async {
    // for changing focus and popoing keyboard
    FocusScope.of(context).unfocus();

    final user = await FirebaseAuth.instance.currentUser();

    //sending message to firestore
    Firestore.instance.collection('chat').add({
      "text": _enteredMessage,
      "createdAt": Timestamp.now(),
      "userId": user.uid,
    });
    //clearing textfield
    _controllerText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controllerText,
              decoration: InputDecoration(
                labelText: "Send a message..",
              ),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMesage,
          ),
        ],
      ),
    );
  }
}
