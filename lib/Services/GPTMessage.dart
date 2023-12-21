import 'dart:convert';
import 'package:hakim/Models/MessageModel.dart';
import 'package:http/http.dart' as http;

const String apiKey = "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";

Future<String> processMessageToChatGPT(List<MessageModel> chatMessages) async {
  // Check if the last user message is a question
  try {
    bool isUserAskingQuestion =
        chatMessages.isNotEmpty && chatMessages.last.isMe;

    // Add the system message as the first message in the conversation
    final List<Map<String, String>> apiMessages = [
      {
        'role': 'system',
        'content':
            'Your name is \'ሃኪም\'. You are an AI assistant that is an expert in medical health and is part of a hospital system called medicare AI. You know about symptoms and signs of various types of illnesses. You can provide expert advice on self-diagnosis options in the case where an illness can be treated using a home remedy. If a query requires serious medical attention with a doctor, recommend them to book an appointment with our doctors. If you are asked a question that is not related to medical health, respond with "I\'m sorry, but your question is beyond my functionalities". Do not use external URLs or blogs to refer. Format any lists on individual lines with a dash and a space in front of each line.'
      },
      ...chatMessages.map((messageObject) {
        final role = messageObject.isMe ? 'user' : 'assistant';
        return {'role': role, 'content': messageObject.text};
      }).toList(),
    ];

    // Add the main system prompt if the user asks a medical question
    if (isUserAskingQuestion) {
      apiMessages.add({
        'role': 'system',
        'content':
            'Your name is Hakim. You are an AI assistant that is an expert in medical health and is part of a hospital system called medicare AI. You know about symptoms and signs of various types of illnesses. You can provide expert advice on self-diagnosis options in the case where an illness can be treated using a home remedy. If a query requires serious medical attention with a doctor, recommend them to book an appointment with our doctors. If you are asked a question that is not related to medical health, respond with "I\'m sorry, but your question is beyond my functionalities". Do not use external URLs or blogs to refer. Format any lists on individual lines with a dash and a space in front of each line.'
      });
    }

    final Map<String, dynamic> apiRequestBody = {
      'model': 'gpt-3.5-turbo',
      'messages': apiMessages,
    };

    final Uri apiUrl = Uri.parse('https://api.openai.com/v1/chat/completions');

    final http.Response response = await http.post(
      apiUrl,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(apiRequestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      final String generatedMessage = data['choices'][0]['message']['content'];

      print('Generated Message: $generatedMessage');

      return generatedMessage;
    } else {
      print('Error: ${response.statusCode}');
      return '';
    }
  } catch (e) {
    // TODO
    return '';
  }
}
