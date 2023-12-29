import 'package:flutter/material.dart';
import 'package:hakim/Models/MessageModel.dart';

class MessagesProvider extends ChangeNotifier {
  MessageModel prompt = MessageModel(
      text: 'hello, I am Hakim, How can i assist you?', isMe: false);
  List<MessageModel> _messages = [];

  MessagesProvider() {
    _messages.add(prompt);
  }

  List<MessageModel> get messages => _messages;

  void addMessage(MessageModel message) {
    _messages.add(message);
    notifyListeners();
  }
}
