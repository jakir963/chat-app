import 'package:chat_app/component/my_drawer.dart';
import 'package:chat_app/services/auth/auth_services.dart';
import 'package:flutter/material.dart';

import '../component/user_tile.dart';
import '../services/chat/chat services.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  // Build a list of users
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text("Error");
        }
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        // return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  // Build individual list item for each user
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    // Only display other users, not the current one
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          // Tap to go to chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"], // FIX: Pass the user's unique ID
              ),
            ),
          );
        },
      );
    } else {
      // Return an empty container for the current user
      return Container();
    }
  }
}