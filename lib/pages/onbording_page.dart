import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';

import '../src_firebase/authentication.dart';
import 'login_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: OnBoard(
        imageWidth: 350,
        pageController: _pageController,
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        onSkip: () {},
        // Either Provide onDone Callback or nextButton Widget to handle done state

        onDone: () {},
        onBoardData: onBoardData,
        titleStyles: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.15,
        ),
        descriptionStyles: const TextStyle(
          fontSize: 16,
          color: Colors.white70,
        ),
        pageIndicatorStyle: const PageIndicatorStyle(
          width: 100,
          inactiveColor: Colors.white70,
          activeColor: Colors.white,
          inactiveSize: Size(8, 8),
          activeSize: Size(12, 12),
        ),
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        skipButton: TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AuthFunc(
                  loggedIn: false,
                  signOut: () {},
                ),
              ),
            );
          },
          child: const Text(
            "Skip",
            style: TextStyle(color: Colors.lightGreenAccent),
          ),
        ),
        // Either Provide onDone Callback or nextButton Widget to handle done state
        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return InkWell(
              onTap: () => _onNextTap(state),
              child: Container(
                width: 230,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white70,
                ),
                child: Text(
                  state.isLastPage ? "Done" : "Next",
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      //print("nextButton pressed");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginSignUp()),
      );
    }
  }
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Request A Ride",
    description:
        "Need to go places, Use The Lift Club App to Request a ride to your destination",
    imgUrl: "assets/images/logo1.png",
  ),
  const OnBoardModel(
    title: "Offer A Ride",
    description: "Use The Lift Club App to Offer a ride to your destination",
    imgUrl: 'assets/images/route.png',
  ),
  const OnBoardModel(
    title: "Split The Cost",
    description:
        "Make an offer for the ride or ask for a price for the ride or be kind and offer a free ride",
    imgUrl: 'assets/images/pay.png',
  ),
];
