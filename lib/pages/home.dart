import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/pages/post_page.dart';
import 'package:line_icons/line_icon.dart';

import 'notice_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required String title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logoText(),
              const SizedBox(
                height: 30,
              ),
              Card(
                color: Colors.white70,
                shape: RoundedRectangleBorder(
                    // side: const BorderSide(
                    //   color: Colors.orangeAccent,
                    // ),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 20, right: 16.0, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Welcome to the Lift Club Nav Screen',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white70,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const MyHomePage(title: '')),
                    // );
                  },
                  icon: const Icon(Icons.menu, size: 30, color: Colors.blueGrey),
                  label: const Text('Menu',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white70,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NoticePage()),
                    );
                  },
                  icon: const Icon(Icons.departure_board,
                      size: 30, color: Colors.blueGrey),
                  label: const Text('Notice Board',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white70,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PostPage()),
                    );
                  },
                  icon: const Icon(Icons.post_add_outlined,
                      size: 30, color: Colors.blueGrey),
                  label: const Text('Add Post',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white70,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()),
                    );
                  },
                  icon: const Icon(Icons.account_circle_outlined,
                      size: 30, color: Colors.blueGrey),
                  label: const Text('Profile',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget logoText() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AvatarGlow(
        glowColor: Colors.lightGreen,
        endRadius: 100.0,
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
            radius: 50.0,
            child: Image.asset(
              'assets/images/car1.png',
              height: 90,
              width: 90,
            ),
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
    ],
  );
}
