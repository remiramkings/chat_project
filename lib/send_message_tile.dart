import 'package:chat_project/message_type.dart';
import 'package:chat_project/model/message_model.dart';
import 'package:chat_project/service/share_service.dart';
import 'package:chat_project/service/text_to_pdf_service.dart';
import 'package:chat_project/service/text_to_speech_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'model/user_model.dart';

class SendMessageTile extends StatefulWidget {
  MessageModel message;
  bool isSelected;
  Function onLongPress;
  Function onSelect;
  SendMessageTile(
      {super.key,
      required this.message,
      required this.isSelected,
      required this.onLongPress,
      required this.onSelect});

  @override
  State<SendMessageTile> createState() => SendMessageTileState();
}

class SendMessageTileState extends State<SendMessageTile> {
  bool showIcon = false;

  String getFormatedTime() {
    return DateFormat("hh:mm a").format(widget.message.timeStamp);
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntrinsicWidth(
                child: Stack(
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Expanded(
                              child: GestureDetector(
                                onLongPress: () {
                                  HapticFeedback.vibrate();
                                  setState(() {
                                    showIcon = !showIcon;
                                  });
                                  widget.onLongPress();
                                },
                                onTap: () {
                                  widget.onSelect();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: Color.fromARGB(255, 167, 219, 169),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                255, 167, 219, 169),
                                            blurRadius: 10)
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'You',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 77, 77, 77)),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(widget.message.text),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(getFormatedTime(),
                                              style: const TextStyle(
                                                  fontSize: 10)),
                                          InkWell(
                                            onTap: () {
                                              TexttoSpeechService.getInstance()
                                                  .speak(widget.message.text);
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
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: Image.asset('assets/images/user.png'))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.isSelected,
            child: GestureDetector(
              child: Container(
                  width: double.infinity,
                  color: Color.fromARGB(82, 122, 190, 236)),
              onTap: () {
                widget.onSelect();
              },
            ),
          ),
        ],
      ),
    );
  }
}
