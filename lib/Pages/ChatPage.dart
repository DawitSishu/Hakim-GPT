import 'package:flutter/material.dart';
import 'package:hakim/Models/MessageModel.dart';
import 'package:hakim/Providers/MessageProvider.dart';
import 'package:hakim/Utils/widgets.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var messagesProvider = Provider.of<MessagesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('ሀኪም'),
      ),
      body: Column(
        children: [
          Expanded(
            // child: ListView(
            //   children: [
            //     // Message('Hello', isMe: false),
            //     // Message('Hi there!', isMe: true),
            //   ],)
            child: ListView.builder(
              itemCount: messagesProvider.messages.length,
              itemBuilder: (context, index) {
                var message = messagesProvider.messages[index];
                return Message(message.text, isMe: message.isMe);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 28.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.0),
            IconButton(
              color: Colors.blue.shade800,
              icon: Icon(
                Icons.send,
                size: 35,
              ),
              onPressed: () {
                var messageText = _messageController.text;

                var newMessage = MessageModel(text: messageText, isMe: true);
                var messagesProvider =
                    Provider.of<MessagesProvider>(context, listen: false);
                messagesProvider.addMessage(newMessage);

                _messageController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
