import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:real_chat_app/auth/auth_service.dart';
import 'package:real_chat_app/components/my_drawer.dart';
import 'package:real_chat_app/components/user_tile.dart';
import 'package:real_chat_app/pages/chat_page.dart';
import 'package:real_chat_app/services/chat/chat_services.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // chat & auth services
  final ChatServices _chatServices = ChatServices();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  // build a list of users expect for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatServices.getUsersStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text("Error");
          }
          // loading..
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          // return list view
          print("snapshot.data: ${snapshot.data}");

          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  // build indiividual user list item

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all users expect current user
    if (userData["email"] != _auth.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        receiverEmail: userData["email"],
                        receiverID: userData["uid"],
                      )));
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
