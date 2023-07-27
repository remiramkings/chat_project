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

class ReceivedMessageTile extends StatefulWidget {
  MessageModel message;
  bool isSelected;
  Function onLongPress;
  Function onSelect;
  ReceivedMessageTile(
      {super.key,
      required this.message,
      required this.isSelected,
      required this.onLongPress,
      required this.onSelect});

  @override
  State<ReceivedMessageTile> createState() => ReceivedMessageTileState();
}

class ReceivedMessageTileState extends State<ReceivedMessageTile> {
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
            alignment: Alignment.centerLeft,
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
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset('assets/images/logo.png'),
                          ),
                          SizedBox(width: 5),
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
                                      color: Color.fromARGB(255, 241, 241, 241),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                255, 184, 184, 184),
                                            blurRadius: 10)
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Mor',
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
                          SizedBox(width: 65)
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
          TapRegion(
            onTapOutside: (tap) {
              setState(() {
                showIcon = false;
              });
            },
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: showIcon,
                    child: InkWell(
                      onTap: () {
                        TextToPdfService.getInstance()
                            .createPdf(widget.message.text);
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 184, 184, 184),
                                  blurRadius: 10)
                            ],
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.upload_file_rounded,
                            color: Colors.blue,
                          )),
                    ),
                  ),
                  SizedBox(width: 5),
                  Visibility(
                    visible: showIcon,
                    child: InkWell(
                      onTap: () {
                        ShareService.getInstance()
                            .shareMessage('ToDo-Mor : ${widget.message.text}');
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 184, 184, 184),
                                  blurRadius: 10)
                            ],
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.share,
                            color: Colors.blue,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
