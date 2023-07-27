import 'package:chat_project/activity_ui.dart';
import 'package:chat_project/login.dart';
import 'package:chat_project/providers/message_selection_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

void main() {
  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider<MessageSelectionProvider>(
        create: (context) {
          return MessageSelectionProvider();
        },
      )

    ],
    child: const MyApp(),
    
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', theme: ThemeData(
      primarySwatch: Colors.blue,
      
    ), 
    debugShowCheckedModeBanner: false,
    home: Home());
  }
}


