import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'onbording_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key, required String title}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: AvatarGlow(
            glowColor: Colors.lightGreen,
            endRadius: 140.0,
            duration: const Duration(milliseconds: 2000),
            repeat: true,
            showTwoGlows: true,
            repeatPauseDuration: const Duration(milliseconds: 100),
            child: Material(
// Replace this child with your own
              elevation: 8.0,
              shape: const CircleBorder(),
              child: CircleAvatar(
                backgroundColor: Colors.lightGreenAccent,
                radius: 90.0,
                child: Image.asset(
                  'assets/images/car1.png',
                  height: 200,
                ),
              ),
            ),
          ),
        ));
  }
}
