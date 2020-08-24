import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("chat")
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data.documents;
        return ListView.builder(
          reverse: true, // recent message appear at bottom
          itemCount: chatDocs.length,
          itemBuilder: (context, index) => Text(chatDocs[index]['text']),
        );
      },
    );
  }
}
