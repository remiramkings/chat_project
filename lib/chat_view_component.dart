import 'package:chat_project/message_type.dart';
import 'package:chat_project/received_message_tile.dart';
import 'package:chat_project/send_message_tile.dart';
import 'package:chat_project/service/message_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'model/message_model.dart';

class ChatViewComponent extends StatefulWidget {
  const ChatViewComponent({super.key});

  @override
  State<ChatViewComponent> createState() => ChatViewComponentState();
}

class ChatViewComponentState extends State<ChatViewComponent> {
  Stream<List<MessageModel>>? messagesStream;
  ScrollController scrollController = ScrollController();

  loadMessges() {
    setState(() {
      messagesStream = MessageService.getInstance().getMessagesStream();
    });

    MessageService.getInstance().loadMessages();
  }

  @override
  void initState() {
    loadMessges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 228, 228, 217),
      child: StreamBuilder<List<MessageModel>>(
        stream: messagesStream,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator.adaptive();
          }
          List<MessageModel>? messages = snapshot.data;
          if(messages == null){
            return Text("Loading");
          }

          SchedulerBinding
            .instance
            ?.addPostFrameCallback((_) {
              scrollController.jumpTo(
                scrollController.position.maxScrollExtent
              );
            });

          return ListView.builder(
            controller: scrollController,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return messages[index].type == MessageType.send
                  ? SendMessageTile(message: messages[index])
                  : ReceivedMessageTile(message: messages[index]);
            },
          );
        }
      ),
    );
  }
}
