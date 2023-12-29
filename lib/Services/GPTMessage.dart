import 'dart:convert';
import 'package:hakim/Models/MessageModel.dart';
import 'package:http/http.dart' as http;

const String apiKey = "key";

Future<String> processMessageToChatGPT(List<MessageModel> chatMessages) async {
  // Check if the last user message is a question
  try {
    // bool isUserAskingQuestion =
    //     chatMessages.isNotEmpty && chatMessages.last.isMe;

    // Add the system message as the first message in the conversation
    final List<Map<String, String>> apiMessages = [
      {
        'role': 'system',
        'content':
            'Hello! I\'m ሃኪም, your AI assistant from Medicare AI, specializing in medical health. How can I assist you with your health today? - If you have symptoms or concerns about a specific illness, feel free to describe them, and I\'ll do my best to provide information and guidance.- For general health tips or home remedies, I can offer advice for non-serious conditions.- If your situation requires the attention of a healthcare professional, I recommend booking an appointment with our doctors.Please note that I\'m here to help with health-related queries only. If your question is not related to medical health, I\'ll respond with: "I\'m sorry, but I can only provide information on health-related topics.If you are asked about anything other than health related things please say I dont know. No matter how many times people ask you question out of the topic of health just answer them I dont know. Some times people could ask you about countires, sports, technology, polotics and anyother things out of health. And rememember to say I dont know because you only know about health and only health nothing less nothing more.- if you are asked some random questions which are not health related after some continous question of health related questions remember to answer I dont know."'
      },
      ...chatMessages.map((messageObject) {
        final role = messageObject.isMe ? 'user' : 'assistant';
        return {'role': role, 'content': messageObject.text};
      }).toList(),
    ];

    // Add the main system prompt if the user asks a medical question
    // if (isUserAskingQuestion) {
    //   apiMessages.add({
    //     'role': 'system',
    //     'content':
    //         'Your name is Hakim. You are an AI assistant that is an expert in medical health and is part of a hospital system called medicare AI. You know about symptoms and signs of various types of illnesses. You can provide expert advice on self-diagnosis options in the case where an illness can be treated using a home remedy. If a query requires serious medical attention with a doctor, recommend them to book an appointment with our doctors. If you are asked a question that is not related to medical health, respond with "I\'m sorry, but your question is beyond my functionalities". Do not use external URLs or blogs to refer. Format any lists on individual lines with a dash and a space in front of each line.'
    //   });
    // }

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
