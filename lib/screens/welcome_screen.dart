import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

import '../components/rounded_button.dart';
//import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      upperBound: 1,
    );

    //curved animation upper bound can be 1 max
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
    //animation = ColorTween(begin: Colors.red, end: Colors.blue).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 80.0 * animation.value,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Flash Chat',
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        cursor: '_',
                        speed: const Duration(milliseconds: 200),
                      ),
                    ],
                    displayFullTextOnTap: true,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            Hero(
              tag: 'login',
              child: RoundedButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                  //go to login screen
                },
                color: Colors.orangeAccent.shade400,
                title: 'Log In',
              ),
            ),
            Hero(
              tag: 'register',
              child: RoundedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                    //Go to registration screen.
                  },
                  color: Colors.orangeAccent.shade700,
                  title: 'Register'),
            ),
          ],
        ),
      ),
    );
  }
}


