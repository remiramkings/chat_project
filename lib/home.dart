import 'package:chat_project/chat_view_component.dart';
import 'package:chat_project/create_send_msg_component.dart';
import 'package:chat_project/model/message_model.dart';
import 'package:chat_project/providers/message_selection_provider.dart';
import 'package:chat_project/service/message_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MessageService messageService = MessageService.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Consumer<MessageSelectionProvider>(
            builder: (context, value, child) {
              return value.isSelectionModeActive()
                  ? selectionModeAppBar(value, context)
                  : normalAppBar();
            },
          ),
        ),
        body: Container(
          child: const Column(children: [
            Expanded(flex: 1, child: ChatViewComponent()),
            CreateSendMsgComponent()
          ]),
        ));
  }

  Widget normalAppBar() {
    return Row(
      children: [
        SizedBox(
            height: 35,
            width: 35,
            child: Image.asset('assets/images/logo.png')),
        const SizedBox(width: 15),
        const Text('Mor')
      ],
    );
  }

  Widget selectionModeAppBar(
      MessageSelectionProvider selectionProvider, BuildContext context) {
    List<MessageModel> selectedMessages = selectionProvider.getSelected();
    int numberOfSelected = selectedMessages.length;
    return Row(
      children: [
        InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            selectionProvider.clear();
          },
        ),
        SizedBox(width: 15),
        Text('Selected $numberOfSelected'),
        Expanded(flex: 1, child: Text('')),
        InkWell(
          child: Icon(Icons.delete),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('Delete $numberOfSelected messages?'),
                  actions: [
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: Text("Yes"),
                      onPressed: () {
                        messageService.deleteSelected(selectedMessages);
                        selectionProvider.clear();
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              },
            );
          },
        )
      ],
    );
  }
}
