import 'package:chat_app/models/massage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ChatService {
  //get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth =FirebaseAuth.instance;

// get user stream

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }
//send massage
  Future<void> sendMessage (String receiverID, message) async{
    // get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new massage
    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp
    );

    // construct chat room ID for the two users(stored)

    List<String>ids = [currentUserID,receiverID];
    ids.sort();// MakeSure any two person have same ids
    String chatRoomID = ids.join('_');
    //add new massage to database
    await _firestore.collection("chat_rooms").doc(chatRoomID).collection("message").add(newMessage.toMap());

  }


//get massage
  Stream<QuerySnapshot> getMessage(String userID, String otherUserID){
    //construct room ID for two people
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore.collection("chat_rooms")
        .doc(chatRoomID)
        .collection("message")
        .orderBy("timestamp",descending:false)
        .snapshots();
  }
}