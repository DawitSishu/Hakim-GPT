import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hakim/Pages/ChatPage.dart';
import 'package:hakim/Pages/LoginPage.dart';
import 'package:hakim/Utils/widgets.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // logo
            // const Icon(Icons.lock, size: 100, color: Colors.black),
            const SizedBox(height: 20),
            Image.asset('assets/images/x.png', height: 200),

            const SizedBox(height: 20),
            Center(
              child: Text(
                'Sign Up To Hakim/ሃኪም',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputBox(
                        inputLabel: "Email",
                        placeHolder: "Enter Your Email Address",
                        update: (value) {
                          email = value;
                        }),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputBox(
                      inputLabel: "Password",
                      placeHolder: "************",
                      update: (value) {
                        password = value;
                      },
                      isPassword: true,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 25),
                  CustomButton(
                    label: "Sign Up",
                    onPressed: () async {
                      try {
                        if (email.isEmpty || password.isEmpty) {
                          showSnackbar(context,
                              text: 'Please include all required fields!!');
                          return;
                        }
                        final auth = FirebaseAuth.instance;

                        await auth.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        successSnackbar(
                            text: "signed-up successfully", context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatPage()),
                        );
                      } catch (e) {
                        showSnackbar(
                            text: "ERROR: Failed to signup, Try again!",
                            context);
                        return;
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Log In now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
