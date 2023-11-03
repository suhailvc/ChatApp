import 'package:chat_app/application/message_provider/message_provider.dart';
import 'package:chat_app/domain/message_model.dart/message_model.dart';
import 'package:chat_app/infrastructure/push_notification/push_notification.dart';
import 'package:chat_app/presentation/screen/chat_screen/widget/message_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatScreen extends StatelessWidget {
  final String token;
  final String fromId;
  final String title;

  const ChatScreen(
      {required this.token,
      required this.fromId,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.08,
        title: Text(
          title,
        ),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.02),
            Expanded(
              child: Consumer<MessageCreationProvider>(
                builder: (context, messageProvider, _) {
                  return FutureBuilder<List<MessageModel>>(
                    future: messageProvider.getAllMessages(fromId),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return const Center(child: Text('No chats'));
                      }

                      final messages = snapshot.data!;

                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: size.height * 0.02),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          DateTime postDateTime =
                              DateTime.parse(messages[index].time.toString());
                          bool isCurrentUser = messages[index].userId == userId;

                          return Column(
                            crossAxisAlignment: isCurrentUser
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: isCurrentUser
                                        ? Colors.teal
                                        : Colors.teal[300],
                                    borderRadius: isCurrentUser
                                        ? const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          )
                                        : const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          )),
                                child: Text(
                                  messages[index].message!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  timeago
                                      .format(postDateTime, allowFromNow: true)
                                      .toString(),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: size.height * 0.07,
                color: Colors.white,
                child: Row(
                  children: [
                    const Expanded(
                      child: MessageField(),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        context
                            .read<MessageCreationProvider>()
                            .addMessage(fromId);
                        sendPushNotification(
                            token, 'user', ' send you a message');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Colors.teal,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
