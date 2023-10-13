import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../progress_messages/progress_widet_dialog.dart';
import 'home.dart';

class LoginSignUp extends StatefulWidget {
  const LoginSignUp({Key? key}) : super(key: key);

  @override
  State<LoginSignUp> createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  final userRef = FirebaseFirestore.instance.collection("users");

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool signUpPage = true;
  String btnText = "SignUp";
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: navigationOption(),
              ),
              const SizedBox(
                height: 30,
              ),
              logoText(),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: signUpPage,
                child: Column(
                  children: [
                    userNameTextField(),
                    phoneTextField(),
                  ],
                ),
              ),
              emailTextField(),
              passwordTextField(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen()),
                          );
                        },
                        child: Text(
                          !signUpPage ? "Forgot Password?" : '',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              signInSignUp(),
            ],
          ),
        ),
      ),
    );
  }

  Widget navigationOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              signUpPage = true;
              btnText = "SignUp";
            });
          },
          child: Text(
            "SignUp",
            style: TextStyle(
                color: signUpPage ? Colors.white : Colors.grey, fontSize: 25),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              signUpPage = false;
              btnText = "Login";
            });
          },
          child: Text(
            "Login",
            style: TextStyle(
                color: !signUpPage ? Colors.white : Colors.grey, fontSize: 25),
          ),
        ),
      ],
    );
  }

  Widget logoText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AvatarGlow(
          glowColor: Colors.lightGreen,
          endRadius: 50.0,
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
              radius: 30.0,
              child: Image.asset(
                'assets/images/car1.png',
                height: 50,
                width: 70,
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

  Widget userNameTextField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        alignment: Alignment.centerLeft,
        height: 60,
        decoration: kBoxDecor,
        child: TextFormField(
          controller: userNameController,
          keyboardType: TextInputType.text,
          style:
              const TextStyle(color: Colors.blueGrey, fontFamily: 'Opens-ans'),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.account_circle_outlined,
              color: Colors.blueGrey,
            ),
            hintText: "Enter your username",
          ),
        ),
      ),
    );
  }

  Widget phoneTextField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        alignment: Alignment.centerLeft,
        height: 60,
        decoration: kBoxDecor,
        child: TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          style:
              const TextStyle(color: Colors.blueGrey, fontFamily: 'Opens-ans'),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.phone_android_outlined,
              color: Colors.blueGrey,
            ),
            hintText: "Enter your phone number",
          ),
        ),
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        alignment: Alignment.centerLeft,
        height: 60,
        decoration: kBoxDecor,
        child: TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style:
              const TextStyle(color: Colors.blueGrey, fontFamily: 'Opens-ans'),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.email_outlined,
              color: Colors.blueGrey,
            ),
            hintText: "Enter you Email",
          ),
        ),
      ),
    );
  }

  Widget passwordTextField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        alignment: Alignment.centerLeft,
        height: 60,
        decoration: kBoxDecor,
        child: TextFormField(
          controller: passwordController,
          keyboardType: TextInputType.text,
          obscureText: true,
          style:
              const TextStyle(color: Colors.blueGrey, fontFamily: 'Opens-ans'),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.lock_outlined,
              color: Colors.blueGrey,
            ),
            hintText: "Enter you password",
          ),
        ),
      ),
    );
  }

  Widget signInSignUp() {
    return ElevatedButton(
        onPressed: () {
          (signUpPage) ? _register() : _login();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white70,
          foregroundColor: Colors.blueGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            btnText,
            style: const TextStyle(fontSize: 24),
          ),
        ));
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _register() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: "Registering, please wait...");
        });

    final User? user = (await _auth
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim())
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMsg(context, "$errMsg", "Error");
      if (kDebugMode) {
        print("Our Error message: $errMsg");
      }
    }))
        .user;
    if (user != null) {
      userRef
          .doc(user.uid)
          .set({
            "name": userNameController.text.trim(),
            "email": emailController.text.trim(),
            "phone": phoneController.text.trim()
          })
          .then((value) => null)
          .catchError((onError) {});
      Navigator.pop(context);
      displayToastMsg(context, "Congratulations, account created", "Success");
      if (kDebugMode) {
        print("User created successfully");
      }
      setState(() {
        signUpPage = false;
        btnText = "Login";
      });
    } else {
      Navigator.pop(context);
      displayToastMsg(context, "User account creation failed", "Failed");
      if (kDebugMode) {
        print("User account creation failed");
      }
    }
  }

  void _login() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: "Verifying Login, please wait...");
        });

    final User? user = (await _auth
            .signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim())
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMsg(context, "$errMsg", "Error");
      if (kDebugMode) {
        print("Our Error message: $errMsg");
      }
    }))
        .user;
    if (user != null) {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MyHomePage(
                    title: '',
                  )));
      if (kDebugMode) {
        print("Login Successful");
      }
    } else {
      Navigator.pop(context);
      displayToastMsg(context, "Login failed", "Failed");
      if (kDebugMode) {
        print("Login failed");
      }
    }
  }

  final kBoxDecor = BoxDecoration(
      color: Colors.white70,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6.0,
          offset: Offset(0, 2),
        )
      ]);
}

Future<void> displayToastMsg(
    BuildContext context, String msg, String title1) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title1),
          content: Text(msg),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
