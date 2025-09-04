import 'package:chat_app/component/chat_bubble.dart';
import 'package:chat_app/component/my_textfield.dart';
import 'package:chat_app/services/auth/auth_services.dart';
import 'package:chat_app/services/chat/chat%20services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID; // Added this line to define the named parameter

   ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID, // Added this line to require the parameter
  });
  //text controller
  final TextEditingController _messageController = TextEditingController();

  //chat & auth services
 final ChatService _chatService = ChatService();
 final AuthService _authService = AuthService();

 //send message

  void sendMessage ()async{
    //if there is something inside the textField

    if (_messageController.text.isNotEmpty){
      //send the message

      await _chatService.sendMessage(receiverID, _messageController.text);

      //clear controller
      _messageController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body:
      Column(
        children: [

          //display all messages

          Expanded(child: _buildMessageList(),),


          //user Input
          _buildUserInput()

        ],
      ),
    );
  }

  //build message list

Widget _buildMessageList(){
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessage(receiverID, senderID),
        builder: (context, snapshot){

          //errors
          if (snapshot.hasError){
            return Text("Error!");
          }

          // loading
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Text("Loading...");
          }
          // return list view
          return ListView(
            children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          );
        }
    );
}

// build messageItem

  Widget _buildMessageItem(DocumentSnapshot doc){
    Map <String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser() !.uid;

    // a;ign message to the right else left
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(alignment: alignment,
      child: Column(
        crossAxisAlignment:
        isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
          isCurrentUser: isCurrentUser,
          message: data["message"]
      )



        ],
      ),
    );
  }

  // build message input

Widget _buildUserInput (){
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          // text field should take most of the space
          Expanded(
              child: MyTextfield(
                  hintText: "write your message here",
                  obscureText: false,
                  controller: _messageController
              )
          ),
          //send button
          Container( decoration: BoxDecoration(
            color: Colors.blue.shade500,
            shape: BoxShape.circle
          ),
            margin: EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: sendMessage,
                icon: const Icon(Icons.arrow_upward)
            ),
          )
        ],
      ),
    );
}


}
