import 'dart:async';

import 'package:chat_project/message_type.dart';

import '../model/message_model.dart';
import '../model/user_model.dart';

class MessageService{
  static MessageService _instance = MessageService();
  
  final StreamController<List<MessageModel>> _streamController = StreamController<List<MessageModel>>();

  static MessageService getInstance(){
    return _instance;
  }

  List<MessageModel> messages = [
    MessageModel(text: "asdasdasd asd", type: MessageType.send, timeStamp: DateTime.now(), user: User(id: 1, name: "You")),
    MessageModel(text: "sadaj dfs f sdf sdf sdfsdf sd sd sd sd fsd fsdf sdf sdf sdsdoija", type: MessageType.send, timeStamp: DateTime.now(), user: User(id: 1, name: "You"))
  ];

  Stream<List<MessageModel>> getMessagesStream(){
    return _streamController.stream;
  }

  Future createMessages(MessageModel messageModel){
    messages.add(messageModel);
    return Future.delayed(const Duration(milliseconds: 100));
  }

  loadMessages(){
    _streamController.add(messages);
  }
}