import 'package:chat_project/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceivedMessageTile extends StatefulWidget {
  MessageModel message;
  ReceivedMessageTile({super.key, required this.message});

  @override
  State<ReceivedMessageTile> createState() => ReceivedMessageTileState();
}

class ReceivedMessageTileState extends State<ReceivedMessageTile> {

  String getFormatedTime() {
    return DateFormat("hh:mm a").format(widget.message.timeStamp);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Color.fromARGB(255, 241, 241, 241),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 184, 184, 184), blurRadius: 10)
                ]),
            child: IntrinsicWidth(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  children: [
                    Text(
                      'More',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(flex: 1, child: Text(''))
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(''),
                    Expanded(flex: 1, child: Text(widget.message.text)),
                  ],
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
              ]),
            ),
          )
        ],
      ),
    );
  }
}
