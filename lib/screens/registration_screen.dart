import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
  static const routeName = '/register-screen';
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                    textAlign: TextAlign.center,
                    decoration:
                        kTextInput.copyWith(hintText: 'Enter Your Email Here'),
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
                    textAlign: TextAlign.center,
                    decoration: kTextInput.copyWith(
                        hintText: 'Enter Your Password Here'),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    title: 'Register',
                    color: Colors.blueAccent,
                    onPressed: () async {
                      setState(() {
                        spinner = true;
                      });
                      //print('email $email , password $password');
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email!, password: password!);
                        if (newUser != null) {
                          spinner = false;
                          Navigator.of(context).pushNamed(ChatScreen.routeName);
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
