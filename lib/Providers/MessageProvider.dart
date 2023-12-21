import 'package:flutter/material.dart';
import 'package:hakim/Models/MessageModel.dart';

class MessagesProvider extends ChangeNotifier {
  List<MessageModel> _messages = [];

  List<MessageModel> get messages => _messages;

  void addMessage(MessageModel message) {
    _messages.add(message);
    notifyListeners();
  }
}
