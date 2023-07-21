import 'package:share_plus/share_plus.dart';

class ShareService{

  static final ShareService _instance = ShareService();

  static getInstance(){
    return _instance;
  }

  shareMessage(String text){
    Share.share(text);
  }
}