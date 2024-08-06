import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  const ChatBubble({super.key, required this.message, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
          color: isSender ? Colors.green : Colors.grey.shade500,
          borderRadius: BorderRadius.circular(10)),
      child: Text(message,
          style: TextStyle(
              color: isSender ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500)),
    );
  }
}
