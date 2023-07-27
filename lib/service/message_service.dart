import 'dart:async';

import 'package:chat_project/message_type.dart';

import '../model/message_model.dart';
import '../model/user_model.dart';

class MessageService {
  static MessageService _instance = MessageService();

  final StreamController<List<MessageModel>> _streamController =
      StreamController<List<MessageModel>>();

  static MessageService getInstance() {
    return _instance;
  }

  List<MessageModel> messages = [
    MessageModel(
        id: 1,
        text: "Hi",
        type: MessageType.received,
        timeStamp: DateTime.now(),
        user: User(id: 1, name: "More")),
    MessageModel(
        id: 2,
        text: "Hello",
        type: MessageType.send,
        timeStamp: DateTime.now(),
        user: User(id: 1, name: "More")),
  ];

  Stream<List<MessageModel>> getMessagesStream() {
    return _streamController.stream;
  }

  Future createMessages(MessageModel messageModel) {
    messageModel.id = messages.length + 1;
    messages.add(messageModel);
    return Future.delayed(const Duration(milliseconds: 100));
  }

  loadMessages() {
    _streamController.add(messages);
  }

  deleteSelected(List<MessageModel> selected) {
    selected.forEach((selectedMessage) {
      var index =
          messages.indexWhere((message) => message.id == selectedMessage.id);
      if(index<0){
        return;
      }
      messages.removeAt(index);
      
    });
    loadMessages();
  }
}
