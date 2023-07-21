import 'package:chat_project/model/message_model.dart';
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'You',
                      style: TextStyle(color: Color.fromARGB(255, 77, 77, 77)),
                    ),
                  )
                ],
              ),
              SizedBox(height: 5),
              SizedBox(
              
                child: Text(widget.message.text),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(getFormatedTime(), style: TextStyle(fontSize: 10)),
                  ),
                  Icon(
                    Icons.mic,
                    size: 20,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
