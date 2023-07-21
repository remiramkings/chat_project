import 'package:chat_project/model/message_model.dart';
import 'package:chat_project/service/text_to_speech_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SendMessageTile extends StatefulWidget {
  MessageModel message;
  SendMessageTile({super.key, required this.message});

  @override
  State<SendMessageTile> createState() => SendMessageTileState();
}

class SendMessageTileState extends State<SendMessageTile> {

  String getFormatedTime() {
    return DateFormat("hh:mm a").format(widget.message.timeStamp);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicWidth(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Color.fromARGB(255, 167, 219, 169),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 167, 219, 169), blurRadius: 10)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                        const Text(
                          'You',
                          style: TextStyle(color: Color.fromARGB(255, 77, 77, 77)),
                        ),
                      const SizedBox(height: 5),
                      Text(widget.message.text),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(getFormatedTime(), style: const TextStyle(fontSize: 10)),
                          InkWell(
                            onTap: (){
                              TexttoSpeechService.getInstance().speak(widget.message.text);
                            },
                            child: const Icon(
                              Icons.mic,
                              size: 20,
                              color: Colors.blue,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
             const SizedBox(width: 5),
              Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                    color: Colors.white
                    ),
                    child: Image.asset('assets/images/user.png')
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
