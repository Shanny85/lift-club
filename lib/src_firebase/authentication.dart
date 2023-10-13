import 'package:flutter/material.dart';
import 'package:lifts_app/src_firebase/widgets.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: StyledButton(
              onPressed: () {
                !loggedIn
                    ? Navigator.of(context).pushNamed('/sign-in')
                    : signOut();
              },
              child: !loggedIn
                  ? const Text(
                'Sign In/Sign Up',
                style: TextStyle(fontSize: 20),
              )
                  : const Text(
                'Sign Out',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
        Visibility(
          visible: loggedIn,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 8),
            child: StyledButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/profile');
              },
              child: const Text('Profile'),
            ),
          ),
        ),
      ],
    );
  }
}
