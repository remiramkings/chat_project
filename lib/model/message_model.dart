import 'package:chat_project/model/user_model.dart';

import '../message_type.dart';

class MessageModel{
  String text;
  MessageType type;
  DateTime timeStamp;
  User user;
  

  MessageModel({
    required this.text,
    required this.type,
    required this.timeStamp,
    required this.user
  });
}