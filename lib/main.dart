import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hakim/Pages/ChatPage.dart';
import 'package:hakim/Pages/LoginPage.dart';
import 'package:hakim/Providers/MessageProvider.dart';
import 'package:provider/provider.dart';

// #e12cc7
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
  ));
  runApp(ChangeNotifierProvider(
      create: (context) => MessagesProvider(),
      child: MaterialApp(
        title: 'Yene',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
        ),
        initialRoute: 'login',
        debugShowCheckedModeBanner: false,
        routes: {
          'chat': (context) => ChatPage(),
          'login': (context) => LoginPage()
        },
      )));
}
