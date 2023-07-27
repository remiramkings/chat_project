import 'package:chat_project/model/user_model.dart';

import '../message_type.dart';

class MessageModel{
  int id;
  String text;
  MessageType type;
  DateTime timeStamp;
  User user;
  

  MessageModel({
    required this.id,
    required this.text,
    required this.type,
    required this.timeStamp,
    required this.user
  });
}