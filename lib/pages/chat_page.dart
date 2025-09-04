import 'package:chat_app/services/auth/auth_services.dart';
import 'package:flutter/material.dart';

import '../component/my_textfield.dart';
import '../services/chat/chat services.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;


  const ChatPage({super.key, required this.receiverEmail,required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // send message
  void sendMessage() async {
    // only send message if there is something to send
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverEmail,
          _messageController.text
      );
      // clear the text controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverEmail)),
      body: Column(
        children: [
          // messages
          Expanded(
            child: Container(
              // This is where your message list will go
            ),
          ),

          // user input
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                // textfield should take up most of the space
                Expanded(
                  child: MyTextfield(
                    controller: _messageController,
                    hintText: "Enter message",
                    obscureText: false,
                  ),
                ),
                // send button
                IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(
                    Icons.send,
                    color: Colors.green,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}