import 'package:chat_project/model/message_model.dart';
import 'package:chat_project/service/share_service.dart';
import 'package:chat_project/service/text_to_pdf_service.dart';
import 'package:chat_project/service/text_to_speech_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceivedMessageTile extends StatefulWidget {
  MessageModel message;
  ReceivedMessageTile({super.key, required this.message});

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
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicWidth(
          child: Stack(
            children: [
              Row(
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
                  Expanded(
                    child: InkWell(
                      onLongPress: () {
                        setState(() {
                          showIcon = !showIcon;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color.fromARGB(255, 241, 241, 241),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 184, 184, 184),
                                  blurRadius: 10)
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Mor',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 77, 77, 77)),
                            ),
                            const SizedBox(height: 5),
                            Text(widget.message.text),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(getFormatedTime(),
                                    style: const TextStyle(fontSize: 10)),
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

                      SizedBox(width: 65)
                ],
              ),
           
              TapRegion(
                onTapOutside: (tap){
                  setState(() {
                    showIcon = false;
                  });
                },
              
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
              
                      Visibility(
                        visible: showIcon,
                        child: InkWell(
                          onTap: (){
                             TextToPdfService.getInstance().createPdf(widget.message.text);
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
                          onTap: (){
                            ShareService.getInstance().shareMessage('ToDo-Mor : ${widget.message.text}');
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
        ),
      ),
    );
  }
}
