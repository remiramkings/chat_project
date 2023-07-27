import 'package:flutter/material.dart';

import '../model/message_model.dart';

class MessageSelectionProvider extends ChangeNotifier{
  List<MessageModel> selectedItems = [];

   addRemoveMessage(MessageModel msgModel) {
    MessageModel? existingItem =
        selectedItems.where((element) => element.id == msgModel.id).firstOrNull;
    if (existingItem != null) {
      selectedItems.remove(existingItem);
      notifyListeners();
      return;
    }
    selectedItems.add(msgModel);
    notifyListeners();
  }

  bool isMessageSelected(MessageModel msgModel) {
    return selectedItems.any((element) => element.id == msgModel.id);
  }

  bool isSelectionModeActive() {
    return selectedItems.isNotEmpty;
  }

  clear(){
    selectedItems = [];
    notifyListeners();
  }

  List<MessageModel> getSelected(){
    return selectedItems;
  }
}