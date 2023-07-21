import 'package:chat_project/chat_view_component.dart';
import 'package:chat_project/create_send_msg_component.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            SizedBox(
              height: 35,
              width: 35,
              child: Image.asset('assets/images/logo.png')),
              SizedBox(width: 15),
            Text('Mor')
          ],),
        ),
        body: Container(
       
          child: Column(children: [
            Expanded(flex: 1, child: ChatViewComponent()),
            CreateSendMsgComponent()
          ]),
        ));
  }
}
