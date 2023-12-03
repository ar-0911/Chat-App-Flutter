import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

import '../components/Loading.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  bool _isObscure = true;

  void showDialogue(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => Loading(),
    );
  }

  void hideProgressDialogue(BuildContext context) {
    Navigator.of(context).pop(Loading());}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.orangeAccent,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 23, fontWeight: FontWeight.normal),
              onChanged: (value) {
                email = value;
                //Do something with the user input.
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              obscureText: _isObscure,
              cursorColor: Colors.orangeAccent,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 23, fontWeight: FontWeight.normal),
              onChanged: (value) {
                //Do something with the user input.
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                  suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      })),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Hero(
              tag: 'login',
              child: RoundedButton(
                  onPressed: ()async {
                    final navigator = Navigator.of(context);
                    try{
                      showDialogue(context);
                      await _auth.signInWithEmailAndPassword(email: email, password: password);
                      navigator.pop();
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    catch(e){
                      navigator.pop();
                      AlertDialog alert = AlertDialog(
                        title: const Text('Error'),
                        content: Text(e.toString().split(']').last),
                        actions: [
                          TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('OK',style: TextStyle(color: Colors.orange),)),
                        ],
                      );
                      showDialog(context: context, builder: (context) => alert,);
                    }
                  },
                  color: Colors.orangeAccent.shade400,
                  title: 'Log In'),
            ),
          ],
        ),
      ),
    );
  }
}
