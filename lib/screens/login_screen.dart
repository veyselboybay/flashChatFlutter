import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
  static const routeName = '/login-screen';
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  bool spinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      //Do something with the user input.
                      email = value;
                    },
                    style: TextStyle(color: Colors.black87),
                    decoration:
                        kTextInput.copyWith(hintText: 'Enter Your Email Here!'),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    onChanged: (value) {
                      //Do something with the user input.
                      password = value;
                    },
                    style: TextStyle(color: Colors.black87),
                    decoration: kTextInput.copyWith(
                        hintText: 'Enter Your Password Here'),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    title: 'Login',
                    color: Colors.lightBlueAccent,
                    onPressed: () async {
                      setState(() {
                        spinner = true;
                      });
                      try {
                        final loggedInUser =
                            await _auth.signInWithEmailAndPassword(
                                email: email!, password: password!);
                        if (loggedInUser != null) {
                          setState(() {
                            spinner = false;
                          });
                          Navigator.of(context).pushNamed(ChatScreen.routeName);
                          //print(loggedInUser.user!.email);
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
