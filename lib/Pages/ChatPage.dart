import 'package:flutter/material.dart';
import 'package:hakim/Models/MessageModel.dart';
import 'package:hakim/Providers/MessageProvider.dart';
import 'package:hakim/Services/GPTMessage.dart';
import 'package:hakim/Utils/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();
  bool isUserTurn = true;
  ScrollController _scrollController = ScrollController();

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
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messagesProvider.messages.length,
              itemBuilder: (context, index) {
                var message = messagesProvider.messages[index];
                return Message(message.text, isMe: message.isMe);
              },
            ),
          ),
          if (!isUserTurn)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoadingAnimationWidget.waveDots(
                    color: Colors.blue.shade800,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "ሀኪም is generating",
                    style: TextStyle(color: Colors.blue.shade800),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                    enabled: isUserTurn,
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  color: isUserTurn ? Colors.blue.shade800 : Colors.red,
                  icon: Icon(
                    isUserTurn ? Icons.send : Icons.stop,
                    size: 35,
                  ),
                  onPressed: () async {
                    if (isUserTurn) {
                      var messageText = _messageController.text;

                      if (messageText.trim().isNotEmpty) {
                        var newMessage =
                            MessageModel(text: messageText, isMe: true);
                        messagesProvider.addMessage(newMessage);

                        _messageController.clear();

                        setState(() {
                          _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent);
                          isUserTurn = false;
                        });

                        // Call the OpenAI API to process user message
                        await processMessageToChatGPT(
                          messagesProvider.messages,
                        ).then((generatedMessage) {
                          if (isUserTurn) {
                            return;
                          }
                          if (generatedMessage == '') {
                            showSnackbar(context);
                            setState(() {
                              _scrollController.jumpTo(
                                  _scrollController.position.maxScrollExtent);
                              isUserTurn = true;
                            });
                            return;
                          }
                          var assistantMessage =
                              MessageModel(text: generatedMessage, isMe: false);
                          messagesProvider.addMessage(assistantMessage);
                          setState(() {
                            _scrollController.jumpTo(
                                _scrollController.position.maxScrollExtent);
                            isUserTurn = true;
                          });
                        });
                      }
                    } else {
                      setState(() {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                        isUserTurn = true;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
