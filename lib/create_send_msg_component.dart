import 'package:chat_project/message_type.dart';
import 'package:chat_project/model/message_model.dart';
import 'package:chat_project/model/user_model.dart';
import 'package:chat_project/service/message_service.dart';
import 'package:chat_project/service/text_to_speech_service.dart';
import 'package:flutter/material.dart';

class CreateSendMsgComponent extends StatefulWidget {
  const CreateSendMsgComponent({super.key});

  @override
  State<CreateSendMsgComponent> createState() => _CreateSendMsgComponentState();
}

class _CreateSendMsgComponentState extends State<CreateSendMsgComponent> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, left:20, right: 20),
      child: Row(
        children: [
          Expanded(
            flex:1,
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(
                hintText: 'Message'
              ),
            )),
           const SizedBox(width: 15),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: InkWell(
              child: const Icon(Icons.send,
              color: Colors.green,
              ),
              onTap:() async {
                await MessageService.getInstance().createMessages(MessageModel(text: messageController.text, type: MessageType.send, timeStamp: DateTime.now(), user: User(id: 2, name: 'Adi')));
                MessageService.getInstance().loadMessages();
                messageController.text = "";
          
              },
            ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: InkWell(
              onTap: (){
                TexttoSpeechService.getInstance().speak(messageController.text);
              },
              child: const Icon(Icons.mic,
              color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}