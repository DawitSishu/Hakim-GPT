import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hakim/Pages/ChatPage.dart';

// #e12cc7
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
  ));
  runApp(MaterialApp(
    title: 'Yene',
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
    ),
    initialRoute: 'chat',
    debugShowCheckedModeBanner: false,
    routes: {'chat': (context) => ChatPage()},
  ));
}
