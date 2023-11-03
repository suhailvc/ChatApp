import 'package:chat_app/application/message_provider/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageField extends StatelessWidget {
  const MessageField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: context.read<MessageCreationProvider>().messageController,
      maxLines: 1,
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: 'Write your message...',
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.3),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );
  }
}
