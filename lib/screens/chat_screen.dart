import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(8),
          child: Text("this works"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //snapshot will give us real time data changes
          // so that we can re render our UI
          FirebaseFirestore.instance
              .collection('chats/m0Ol7QhBEHbcs0qWDtoY/messeges')
              .snapshots()
              .listen(
            (event) {
              event.docs.forEach((element) {
                print(element.data()['text']);
              });
            },
          );
        },
      ),
    );
  }
}
