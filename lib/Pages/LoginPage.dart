import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hakim/Pages/SignUpPgae.dart';
import 'package:hakim/Utils/widgets.dart';

import 'ChatPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // const SizedBox(height: 50),
            const SizedBox(height: 20),

            Image.asset('assets/images/x.png', height: 200),

            // logo

            const SizedBox(height: 20),

            // welcome back, you've been missed!
            Center(
              child: Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 50),

            // email textfield
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

                    // sign in button
                    CustomButton(
                      label: "Sign IN",
                      onPressed: () async {
                        try {
                          if (email.isEmpty || password.isEmpty) {
                            showSnackbar(context,
                                text: 'Please include all required fields!!');
                            print("${email} ${password}");
                            return;
                          }
                          final auth = FirebaseAuth.instance;

                          await auth.signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          successSnackbar(
                              text: "signed-in successfully", context);
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
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue, // Customize the color as needed
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
            ),

            const SizedBox(height: 50),

            // or continue with
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Divider(
            //           thickness: 0.5,
            //           color: Colors.grey[400],
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //         child: Text(
            //           'Or continue with',
            //           style: TextStyle(color: Colors.grey[700]),
            //         ),
            //       ),
            //       Expanded(
            //         child: Divider(
            //           thickness: 0.5,
            //           color: Colors.grey[400],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // const SizedBox(height: 50),

            // // google + apple sign in buttons
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: const [
            //     // google button
            //     SquareTile(imagePath: 'assets/images/google.png'),
            //   ],
            // ),

            // const SizedBox(height: 50),

            // not a member? register now
          ],
        ),
      ),
    );
  }
}
