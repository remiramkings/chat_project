import 'package:flutter_tts/flutter_tts.dart';

class TexttoSpeechService{
  static final TexttoSpeechService _instance = TexttoSpeechService();

  static TexttoSpeechService getInstance(){
    return _instance;
  }

  Future speak(String text) async{
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.speak(text);
  }

  

}